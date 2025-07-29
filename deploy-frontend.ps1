# Deploy Frontend to Azure Web App
Write-Host "🚀 Deploying Frontend to Azure..." -ForegroundColor Green

# Set variables
$RESOURCE_GROUP = "consistly-rg"
$WEBAPP_NAME = "consistly-frontend-app"

Write-Host "Building React app..." -ForegroundColor Yellow

# Navigate to frontend directory
cd frontend

# Install dependencies
Write-Host "Installing dependencies..." -ForegroundColor Yellow
npm install

# Build the React app
Write-Host "Building React app..." -ForegroundColor Yellow
npm run build

# Deploy to Azure
Write-Host "Deploying to Azure Web App..." -ForegroundColor Yellow
az webapp deployment source config-local-git --name $WEBAPP_NAME --resource-group $RESOURCE_GROUP

# Get the deployment URL
$DEPLOYMENT_URL = az webapp deployment source config-local-git --name $WEBAPP_NAME --resource-group $RESOURCE_GROUP --query url --output tsv

Write-Host "Deployment URL: $DEPLOYMENT_URL" -ForegroundColor Cyan

# Initialize git and deploy
git init
git add .
git commit -m "Deploy React frontend to Azure"
git remote add azure $DEPLOYMENT_URL
git push azure master

cd ..

Write-Host "✅ Frontend deployment complete!" -ForegroundColor Green
Write-Host "Your frontend should be available at: https://$WEBAPP_NAME.azurewebsites.net" -ForegroundColor Cyan 