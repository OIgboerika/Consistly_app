# Consistly: A Daily Habit Tracker

A modern web application for tracking daily habits and building better routines. Built with FastAPI backend and React frontend. Updated for backend deployment fix.

## 🚀 Live Environments

### Production

- **Frontend**: https://consistly-frontend-app-grgpcdhye5d4aqhk.centralus-01.azurewebsites.net
- **Backend API**: https://consistly-backend-app.azurewebsites.net
- **Azure Portal**: https://portal.azure.com

### Staging

- **Frontend**: https://consistly-frontend-app-grgpcdhye5d4aqhk.centralus-01.azurewebsites.net (same as production)
- **Backend API**: https://consistly-backend-app.azurewebsites.net (same as production)

## 🛠️ Tech Stack

### Backend

- **Framework**: FastAPI (Python)
- **Database**: PostgreSQL
- **Deployment**: Azure App Service
- **Runtime**: Python 3.10

### Frontend

- **Framework**: React.js
- **Build Tool**: Create React App
- **Deployment**: Azure App Service
- **Runtime**: Node.js 18

### DevOps

- **CI/CD**: GitHub Actions
- **Container Registry**: GitHub Container Registry (GHCR)
- **Monitoring**: Prometheus + Grafana
- **Security**: Trivy + Bandit

## 📋 Features

- **User Authentication**: Secure login and registration
- **Habit Management**: Create, edit, and delete daily habits
- **Progress Tracking**: Visual progress indicators and streaks
- **Dashboard**: Beautiful statistics and completion rates
- **Responsive Design**: Works on desktop and mobile

## 🚀 Quick Start

### Prerequisites

- Python 3.10+
- Node.js 18+
- Docker (optional)
- Azure CLI (for deployment)

### Local Development

1. **Clone the repository**

   ```bash
   git clone https://github.com/OIgboerika/Consistly_app.git
   cd Consistly_app
   ```

2. **Backend Setup**

   ```bash
   pip install -r requirements.txt
   uvicorn app.main:app --reload
   ```

3. **Frontend Setup**

   ```bash
   cd frontend
   npm install
   npm start
   ```

4. **Access the application**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8000
   - API Docs: http://localhost:8000/docs

## 🏗️ CI/CD Pipeline

The project includes a comprehensive CI/CD pipeline with:

### Security Scanning

- **Trivy**: Container and filesystem vulnerability scanning
- **Bandit**: Python security linter
- **CodeQL**: GitHub's semantic code analysis

### Testing

- **Backend**: Pytest with coverage reporting
- **Frontend**: React Testing Library
- **Linting**: Flake8 (Python) and ESLint (JavaScript)

### Deployment

- **Automatic**: Triggers on push to `main` branch
- **Multi-environment**: Staging and production deployments
- **Azure Integration**: Direct deployment to Azure App Service

## 📊 Monitoring & Observability

### Metrics Collection

- **Prometheus**: Metrics collection and storage
- **Node Exporter**: System metrics
- **cAdvisor**: Container metrics
- **Postgres Exporter**: Database metrics

### Visualization

- **Grafana**: Custom dashboards for application metrics
- **Real-time Monitoring**: Live performance data
- **Alerting**: Automated alerts for critical issues

### Health Checks

- **Backend**: `/health` endpoint for service health
- **Frontend**: Built-in React error boundaries
- **Database**: Connection health monitoring

## 🔧 Configuration

### Environment Variables

```bash
# Backend
DATABASE_URL=postgresql://user:pass@host:port/db
SECRET_KEY=your-secret-key
ENVIRONMENT=production

# Frontend
REACT_APP_API_URL=https://consistly-backend-app.azurewebsites.net
REACT_APP_ENVIRONMENT=production
```

### Azure Configuration

- **Resource Group**: `consistly-rg`
- **Region**: Central US
- **App Service Plans**: Basic tier
- **Container Registry**: Azure Container Registry

## 📁 Project Structure

```
Consistly_app/
├── app/                    # FastAPI backend
│   ├── main.py            # Main application
│   ├── api/               # API endpoints
│   └── core/              # Core configuration
├── frontend/              # React frontend
│   ├── src/               # Source code
│   ├── public/            # Static assets
│   └── package.json       # Dependencies
├── monitoring/            # Monitoring setup
│   ├── prometheus.yml     # Prometheus config
│   ├── grafana/           # Grafana dashboards
│   └── alerts.yml         # Alert rules
├── .github/workflows/     # CI/CD pipelines
├── docker-compose.yml     # Local development
└── README.md             # This file
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- FastAPI for the excellent backend framework
- React team for the amazing frontend library
- Azure for the cloud infrastructure
- GitHub for the CI/CD platform

---

**Built with ❤️ for better habit tracking**

# Trigger CI/CD Pipeline

this is a minor change
this is a minor change 2
