# Consistly: A Daily Habit Tracker

Consistly is a web application that helps users build and maintain daily habits by tracking their progress and visualizing consistency over time. The project is designed as a real-world DevOps sandbox, implementing modern software engineering and DevOps practices from day one.

---

## Project Scope

- **User Authentication:** Secure sign-up and login for users.
- **Habit Management:** Users can create, edit, and delete daily habits.
- **Habit Tracking:** Mark habits as completed each day and view progress history.
- **Dashboard:** Visualize streaks, completion statistics, and habit categories.
- **(Optional) Habit Categories:** Organize habits by type (e.g., Health, Work).

---

## Tech Stack

- **Backend:** FastAPI (Python)
- **Frontend:** React.js
- **DevOps:** GitHub, GitHub Actions, CI/CD, Branch Protection, Code Review

---

## Local Development Setup

### Backend (FastAPI)

1. **Navigate to backend folder:**
   ```sh
   cd backend
   ```
2. **Install dependencies:**
   ```sh
   bun install
   ```
3. **Run the backend server:**
   ```sh
   bun run src/index.js
   ```

### Frontend (React)

1. **Navigate to frontend folder:**
   ```sh
   cd frontend
   ```
2. **Install dependencies:**
   ```sh
   bun install
   ```
3. **Run the frontend app:**
   ```sh
   bun run src/App.js
   ```

---

## Docker-Based Local Setup

You can run the backend (FastAPI) and a local Postgres database using Docker Compose:

1. **Build and start services:**
   ```sh
   docker-compose up --build
   ```
2. The backend will be available at [http://localhost:8000](http://localhost:8000).
3. To stop services:
   ```sh
   docker-compose down
   ```

---

## Azure Cloud Deployment (with Terraform)

### Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- Docker

### 1. Provision Azure Infrastructure

1. **Login to Azure:**
   ```sh
   az login
   ```
2. **Initialize and apply Terraform:**
   ```sh
   cd infra
   terraform init
   terraform apply -auto-approve
   ```
   - Review and approve the plan when prompted.
3. **Note the outputs:**
   - ACR login server
   - Postgres connection string
   - Backend app public URL

### 2. Manual Cloud Deployment

1. **Build the Docker image:**
   ```sh
   docker build -t <acr_login_server_from_output>/consistly-backend:latest .
   ```
2. **Login to ACR:**
   ```sh
   az acr login --name <acr_name_from_output>
   ```
3. **Push the image:**
   ```sh
   docker push <acr_login_server_from_output>/consistly-backend:latest
   ```
4. **Deploy:**
   - The Container App is configured to pull the latest image from ACR.
   - The backend will be accessible at the public URL output by Terraform.
   - Environment variables (like the Postgres connection string) are set automatically.

---

## Live Environments

### Production Environment

- **Frontend:** https://consistly-app.com
- **Backend API:** https://api.consistly-app.com
- **Monitoring Dashboard:** https://monitoring.consistly-app.com

### Staging Environment

- **Frontend:** https://staging.consistly-app.com
- **Backend API:** https://staging-api.consistly-app.com
- **Monitoring Dashboard:** https://staging-monitoring.consistly-app.com

### Health Check Endpoints

- Production Health: https://consistly-app.com/health
- Staging Health: https://staging.consistly-app.com/health
- API Health: https://api.consistly-app.com/health

## CI/CD Pipeline

The project uses a comprehensive CI/CD pipeline with the following stages:

1. **Security Scanning**

   - Trivy vulnerability scanning
   - Bandit security linter for Python code
   - Dependency vulnerability scanning

2. **Testing**

   - Backend unit tests with coverage
   - Frontend unit tests
   - Integration tests
   - Code linting and quality checks

3. **Build & Push**

   - Multi-stage Docker builds
   - Container image security scanning
   - Push to GitHub Container Registry

4. **Deployment**

   - Automatic deployment to staging on `develop` branch
   - Automatic deployment to production on `main` branch
   - Health checks and rollback capabilities

5. **Monitoring**
   - Prometheus metrics collection
   - Grafana dashboards
   - AlertManager for notifications
   - Application and infrastructure monitoring

## Monitoring & Observability

### Metrics Collected

- Application response times
- Error rates and status codes
- System resource usage (CPU, Memory, Disk)
- Database connection health
- Container restart frequency

### Alerts Configured

- High CPU/Memory usage (>80% for 5 minutes)
- Service downtime (>1 minute)
- High error rates (>5% for 5 minutes)
- High response times (>2 seconds 95th percentile)
- Low disk space (<10%)

### Accessing Monitoring

- **Grafana Dashboard:** https://monitoring.consistly-app.com (admin/admin)
- **Prometheus:** https://monitoring.consistly-app.com:9090
- **AlertManager:** https://monitoring.consistly-app.com:9093

## phase.md

See the `phase.md` file in this repository for:

- The live public URL to the deployed backend
- Screenshots of provisioned Azure resources
- Peer review PR link
- Reflection on IaC and manual deployment

---

## Contribution

- Fork the repo and create a feature branch from `develop`.
- Open a Pull Request for review and merging.
- All contributions require passing CI and at least one review.

---

## License

MIT
