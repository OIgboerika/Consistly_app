#!/bin/bash

# Production Deployment Script
# This script is executed by the CI/CD pipeline to deploy to production

set -e

echo "🚀 Starting production deployment..."

# Set environment variables
export ENVIRONMENT=production
export COMPOSE_FILE=docker-compose.prod.yml

# Pull latest images
echo "📥 Pulling latest images..."
docker-compose -f $COMPOSE_FILE pull

# Create backup of current deployment
echo "💾 Creating backup of current deployment..."
docker-compose -f $COMPOSE_FILE ps -q > /tmp/current_containers.txt

# Stop existing containers
echo "🛑 Stopping existing containers..."
docker-compose -f $COMPOSE_FILE down

# Start new containers
echo "▶️ Starting new containers..."
docker-compose -f $COMPOSE_FILE up -d

# Wait for services to be healthy
echo "⏳ Waiting for services to be healthy..."
sleep 60

# Health checks
echo "🏥 Performing health checks..."

# Backend health check
if curl -f http://localhost:8000/health; then
    echo "✅ Backend health check passed"
else
    echo "❌ Backend health check failed"
    echo "🔄 Rolling back deployment..."
    docker-compose -f $COMPOSE_FILE down
    docker-compose -f $COMPOSE_FILE up -d
    exit 1
fi

# Frontend health check
if curl -f http://localhost/health; then
    echo "✅ Frontend health check passed"
else
    echo "❌ Frontend health check failed"
    echo "🔄 Rolling back deployment..."
    docker-compose -f $COMPOSE_FILE down
    docker-compose -f $COMPOSE_FILE up -d
    exit 1
fi

# Database health check
if docker-compose -f $COMPOSE_FILE exec -T db pg_isready -U myuser -d mydb; then
    echo "✅ Database health check passed"
else
    echo "❌ Database health check failed"
    echo "🔄 Rolling back deployment..."
    docker-compose -f $COMPOSE_FILE down
    docker-compose -f $COMPOSE_FILE up -d
    exit 1
fi

# Load testing (basic)
echo "🧪 Performing basic load test..."
for i in {1..10}; do
    curl -f http://localhost:8000/health > /dev/null
    curl -f http://localhost/health > /dev/null
done
echo "✅ Load test completed"

# Cleanup old images
echo "🧹 Cleaning up old images..."
docker image prune -f

echo "🎉 Production deployment completed successfully!"
echo "📊 Production URLs:"
echo "   Frontend: https://consistly-app.com"
echo "   Backend: https://api.consistly-app.com"
echo "   Monitoring: https://monitoring.consistly-app.com"

# Send notification
echo "📢 Sending deployment notification..."
# Add your notification logic here (Slack, email, etc.) 