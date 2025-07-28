#!/bin/bash

# Azure Deployment Script for Consistly Application
# This script automates the deployment of Consistly to Azure

set -e  # Exit on any error

# Configuration
RESOURCE_GROUP="consistly-rg"
LOCATION="eastus"
ACR_NAME="consistlyacr"
POSTGRES_SERVER="consistly-postgres"
APP_GATEWAY_NAME="consistly-appgateway"
VNET_NAME="consistly-vnet"
SUBNET_NAME="default"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Azure CLI is installed
check_azure_cli() {
    if ! command -v az &> /dev/null; then
        print_error "Azure CLI is not installed. Please install it first."
        print_status "Installation guide: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli"
        exit 1
    fi
    print_status "Azure CLI is installed"
}

# Check if logged in to Azure
check_azure_login() {
    if ! az account show &> /dev/null; then
        print_warning "Not logged in to Azure. Please login first."
        az login
    fi
    print_status "Logged in to Azure"
}

# Create resource group
create_resource_group() {
    print_status "Creating resource group: $RESOURCE_GROUP"
    az group create --name $RESOURCE_GROUP --location $LOCATION --output none
    print_status "Resource group created successfully"
}

# Create Azure Container Registry
create_acr() {
    print_status "Creating Azure Container Registry: $ACR_NAME"
    az acr create \
        --name $ACR_NAME \
        --resource-group $RESOURCE_GROUP \
        --sku Basic \
        --admin-enabled true \
        --output none
    
    print_status "Getting ACR credentials..."
    ACR_USERNAME=$(az acr credential show --name $ACR_NAME --query username --output tsv)
    ACR_PASSWORD=$(az acr credential show --name $ACR_NAME --query passwords[0].value --output tsv)
    
    print_status "Logging in to ACR..."
    az acr login --name $ACR_NAME
    print_status "ACR created and configured successfully"
}

# Create PostgreSQL database
create_postgres() {
    print_status "Creating PostgreSQL server: $POSTGRES_SERVER"
    az postgres flexible-server create \
        --resource-group $RESOURCE_GROUP \
        --name $POSTGRES_SERVER \
        --admin-user consistlyadmin \
        --admin-password "ConsistlySecurePass123!" \
        --sku-name Standard_B1ms \
        --version 14 \
        --storage-size 32 \
        --output none
    
    print_status "Creating database..."
    az postgres flexible-server db create \
        --resource-group $RESOURCE_GROUP \
        --server-name $POSTGRES_SERVER \
        --database-name consistly_db \
        --output none
    
    print_status "PostgreSQL server created successfully"
}

# Build and push Docker images
build_and_push_images() {
    print_status "Building and pushing Docker images..."
    
    # Build backend image
    print_status "Building backend image..."
    docker build -t $ACR_NAME.azurecr.io/consistly-backend:latest .
    
    # Build frontend image
    print_status "Building frontend image..."
    docker build -t $ACR_NAME.azurecr.io/consistly-frontend:latest ./frontend
    
    # Push images
    print_status "Pushing images to ACR..."
    docker push $ACR_NAME.azurecr.io/consistly-backend:latest
    docker push $ACR_NAME.azurecr.io/consistly-frontend:latest
    
    print_status "Images built and pushed successfully"
}

# Create staging environment
create_staging_environment() {
    print_status "Creating staging environment..."
    
    # Get database connection string
    DB_CONNECTION_STRING="postgresql://consistlyadmin:ConsistlySecurePass123!@$POSTGRES_SERVER.postgres.database.azure.com:5432/consistly_db"
    
    # Create backend container
    print_status "Creating backend container..."
    az container create \
        --resource-group $RESOURCE_GROUP \
        --name consistly-backend-staging \
        --image $ACR_NAME.azurecr.io/consistly-backend:latest \
        --dns-name-label consistly-backend-staging \
        --ports 8000 \
        --environment-variables \
            DATABASE_URL="$DB_CONNECTION_STRING" \
            SECRET_KEY="staging-secret-key-$(date +%s)" \
            ENVIRONMENT="staging" \
        --output none
    
    # Create frontend container
    print_status "Creating frontend container..."
    az container create \
        --resource-group $RESOURCE_GROUP \
        --name consistly-frontend-staging \
        --image $ACR_NAME.azurecr.io/consistly-frontend:latest \
        --dns-name-label consistly-frontend-staging \
        --ports 80 \
        --environment-variables \
            REACT_APP_API_URL="http://consistly-backend-staging.eastus.azurecontainer.io:8000" \
            REACT_APP_ENVIRONMENT="staging" \
        --output none
    
    print_status "Staging environment created successfully"
}

# Create production environment
create_production_environment() {
    print_status "Creating production environment..."
    
    # Create virtual network
    print_status "Creating virtual network..."
    az network vnet create \
        --resource-group $RESOURCE_GROUP \
        --name $VNET_NAME \
        --subnet-name $SUBNET_NAME \
        --output none
    
    # Create public IP
    print_status "Creating public IP..."
    az network public-ip create \
        --resource-group $RESOURCE_GROUP \
        --name consistly-pip \
        --sku Standard \
        --output none
    
    # Create Application Gateway
    print_status "Creating Application Gateway..."
    az network application-gateway create \
        --resource-group $RESOURCE_GROUP \
        --name $APP_GATEWAY_NAME \
        --vnet-name $VNET_NAME \
        --subnet $SUBNET_NAME \
        --public-ip-address consistly-pip \
        --http-settings-cookie-based-affinity Enabled \
        --frontend-port 80 \
        --http-settings-port 80 \
        --http-settings-protocol Http \
        --servers consistly-backend-staging.eastus.azurecontainer.io consistly-frontend-staging.eastus.azurecontainer.io \
        --output none
    
    print_status "Production environment created successfully"
}

# Display deployment information
display_deployment_info() {
    print_status "Deployment completed successfully!"
    echo ""
    echo "=== Deployment Information ==="
    echo "Resource Group: $RESOURCE_GROUP"
    echo "Location: $LOCATION"
    echo "Container Registry: $ACR_NAME.azurecr.io"
    echo "PostgreSQL Server: $POSTGRES_SERVER.postgres.database.azure.com"
    echo ""
    echo "=== Staging URLs ==="
    echo "Backend: http://consistly-backend-staging.eastus.azurecontainer.io:8000"
    echo "Frontend: http://consistly-frontend-staging.eastus.azurecontainer.io"
    echo ""
    echo "=== Production URLs ==="
    echo "Application Gateway: $(az network public-ip show --resource-group $RESOURCE_GROUP --name consistly-pip --query ipAddress --output tsv)"
    echo ""
    echo "=== Health Check URLs ==="
    echo "Backend Health: http://consistly-backend-staging.eastus.azurecontainer.io:8000/health"
    echo "Frontend Health: http://consistly-frontend-staging.eastus.azurecontainer.io/health"
    echo ""
    echo "=== Database Connection ==="
    echo "Host: $POSTGRES_SERVER.postgres.database.azure.com"
    echo "Database: consistly_db"
    echo "Username: consistlyadmin"
    echo "Password: ConsistlySecurePass123!"
    echo ""
    print_warning "Remember to change the default passwords in production!"
}

# Main deployment function
main() {
    print_status "Starting Azure deployment for Consistly application..."
    
    # Pre-deployment checks
    check_azure_cli
    check_azure_login
    
    # Deployment steps
    create_resource_group
    create_acr
    create_postgres
    build_and_push_images
    create_staging_environment
    create_production_environment
    
    # Display results
    display_deployment_info
}

# Run main function
main "$@" 