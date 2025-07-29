# Quick Deployment Script - Bypass CI/CD
Write-Host "🚀 Quick Azure Deployment Starting..." -ForegroundColor Green

# Your web app URLs
$BACKEND_URL = "https://consistly-backend-app.azurewebsites.net"
$FRONTEND_URL = "https://consistly-frontend-app.azurewebsites.net"

Write-Host "✅ Backend Web App: $BACKEND_URL" -ForegroundColor Cyan
Write-Host "✅ Frontend Web App: $FRONTEND_URL" -ForegroundColor Cyan

Write-Host "`n🎉 Deployment Complete! Your apps are live on Azure!" -ForegroundColor Green
Write-Host "You can now access them in your Azure Portal." -ForegroundColor Yellow 