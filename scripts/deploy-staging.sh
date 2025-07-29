#!/bin/bash

# Staging Deployment Script
# This script is executed by the CI/CD pipeline to deploy to staging

set -e

echo "🚀 Starting staging deployment..."

# Set environment variables
export ENVIRONMENT=staging
export COMPOSE_FILE=docker-compose.staging.yml

# Pull latest images
echo "📥 Pulling latest images..."
docker compose -f $COMPOSE_FILE pull

# Stop existing containers
echo "🛑 Stopping existing containers..."
docker compose -f $COMPOSE_FILE down

# Start new containers
echo "▶️ Starting new containers..."
docker compose -f $COMPOSE_FILE up -d

# Wait for services to be healthy
echo "⏳ Waiting for services to be healthy..."
sleep 30

# Health checks
echo "🏥 Performing health checks..."

# Backend health check
if curl -f http://localhost:8001/health; then
    echo "✅ Backend health check passed"
else
    echo "❌ Backend health check failed"
    exit 1
fi

# Frontend health check
if curl -f http://localhost:8080/health; then
    echo "✅ Frontend health check passed"
else
    echo "❌ Frontend health check failed"
    exit 1
fi

# Database health check
if docker compose -f $COMPOSE_FILE exec -T db pg_isready -U myuser -d mydb_staging; then
    echo "✅ Database health check passed"
else
    echo "❌ Database health check failed"
    exit 1
fi

echo "🎉 Staging deployment completed successfully!"
echo "📊 Staging URLs:"
echo "   Frontend: http://localhost:8080"
echo "   Backend: http://localhost:8001"
echo "   Grafana: http://localhost:3001" 