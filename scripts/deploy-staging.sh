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

# Show container status
echo "📊 Container status:"
docker compose -f $COMPOSE_FILE ps

# Show logs for debugging
echo "📋 Recent logs:"
docker compose -f $COMPOSE_FILE logs --tail=20

# Wait for services to be healthy
echo "⏳ Waiting for services to be healthy..."
sleep 60

# Health checks
echo "🏥 Performing health checks..."

# Backend health check with retries
echo "🔍 Checking backend health..."
for i in {1..5}; do
    echo "Attempt $i/5: Testing backend health..."
    if curl -f http://localhost:8001/health; then
        echo "✅ Backend health check passed"
        break
    else
        echo "⏳ Backend not ready yet, attempt $i/5..."
        echo "📋 Backend logs:"
        docker compose -f $COMPOSE_FILE logs --tail=10 backend
        if [ $i -eq 5 ]; then
            echo "❌ Backend health check failed after 5 attempts"
            echo "📋 Final backend logs:"
            docker compose -f $COMPOSE_FILE logs backend
            exit 1
        fi
        sleep 30
    fi
done

# Frontend health check with retries
echo "🔍 Checking frontend health..."
for i in {1..5}; do
    echo "Attempt $i/5: Testing frontend health..."
    if curl -f http://localhost:8080/; then
        echo "✅ Frontend health check passed"
        break
    else
        echo "⏳ Frontend not ready yet, attempt $i/5..."
        echo "📋 Frontend logs:"
        docker compose -f $COMPOSE_FILE logs --tail=10 frontend
        if [ $i -eq 5 ]; then
            echo "❌ Frontend health check failed after 5 attempts"
            echo "📋 Final frontend logs:"
            docker compose -f $COMPOSE_FILE logs frontend
            exit 1
        fi
        sleep 30
    fi
done

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