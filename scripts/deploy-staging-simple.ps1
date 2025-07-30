# Simplified Staging Deployment Script for Windows PowerShell
# This script tests only the core services (backend, frontend, database)

$ErrorActionPreference = "Stop"

Write-Host "Starting simplified staging deployment..." -ForegroundColor Green

# Set environment variables
$env:ENVIRONMENT = "staging"
$env:COMPOSE_FILE = "docker-compose.staging-simple.yml"

# Set required environment variables
$env:STAGING_SECRET_KEY = "staging-secret-key-$(Get-Date -UFormat %s)"

# Stop any existing containers
Write-Host "Stopping existing containers..." -ForegroundColor Yellow
docker compose -f $env:COMPOSE_FILE down

# Start new containers
Write-Host "Starting new containers..." -ForegroundColor Yellow
docker compose -f $env:COMPOSE_FILE up -d

# Show container status
Write-Host "Container status:" -ForegroundColor Cyan
docker compose -f $env:COMPOSE_FILE ps

# Show logs for debugging
Write-Host "Recent logs:" -ForegroundColor Cyan
docker compose -f $env:COMPOSE_FILE logs --tail=20

# Wait for services to be healthy
Write-Host "Waiting for services to be healthy..." -ForegroundColor Yellow
Start-Sleep -Seconds 60

# Health checks
Write-Host "Performing health checks..." -ForegroundColor Green

# Backend health check with retries
Write-Host "Checking backend health..." -ForegroundColor Cyan
for ($i = 1; $i -le 5; $i++) {
    Write-Host "Attempt $i/5: Testing backend health..." -ForegroundColor Yellow
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:8001/health" -UseBasicParsing -TimeoutSec 10
        if ($response.StatusCode -eq 200) {
            Write-Host "Backend health check passed" -ForegroundColor Green
            break
        }
    }
    catch {
        Write-Host "Backend not ready yet, attempt $i/5..." -ForegroundColor Yellow
        Write-Host "Backend logs:" -ForegroundColor Cyan
        docker compose -f $env:COMPOSE_FILE logs --tail=10 backend
        
        if ($i -eq 5) {
            Write-Host "Backend health check failed after 5 attempts" -ForegroundColor Red
            Write-Host "Final backend logs:" -ForegroundColor Cyan
            docker compose -f $env:COMPOSE_FILE logs backend
            exit 1
        }
        Start-Sleep -Seconds 30
    }
}

# Frontend health check with retries
Write-Host "Checking frontend health..." -ForegroundColor Cyan
for ($i = 1; $i -le 5; $i++) {
    Write-Host "Attempt $i/5: Testing frontend health..." -ForegroundColor Yellow
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:8080/" -UseBasicParsing -TimeoutSec 10
        if ($response.StatusCode -eq 200) {
            Write-Host "Frontend health check passed" -ForegroundColor Green
            break
        }
    }
    catch {
        Write-Host "Frontend not ready yet, attempt $i/5..." -ForegroundColor Yellow
        Write-Host "Frontend logs:" -ForegroundColor Cyan
        docker compose -f $env:COMPOSE_FILE logs --tail=10 frontend
        
        if ($i -eq 5) {
            Write-Host "Frontend health check failed after 5 attempts" -ForegroundColor Red
            Write-Host "Final frontend logs:" -ForegroundColor Cyan
            docker compose -f $env:COMPOSE_FILE logs frontend
            exit 1
        }
        Start-Sleep -Seconds 30
    }
}

# Database health check
Write-Host "Checking database health..." -ForegroundColor Cyan
try {
    docker compose -f $env:COMPOSE_FILE exec -T db pg_isready -U myuser -d mydb_staging
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Database health check passed" -ForegroundColor Green
    } else {
        Write-Host "Database health check failed" -ForegroundColor Red
        exit 1
    }
}
catch {
    Write-Host "Database health check failed" -ForegroundColor Red
    exit 1
}

Write-Host "Simplified staging deployment completed successfully!" -ForegroundColor Green
Write-Host "Staging URLs:" -ForegroundColor Cyan
Write-Host "   Frontend: http://localhost:8080" -ForegroundColor White
Write-Host "   Backend: http://localhost:8001" -ForegroundColor White 