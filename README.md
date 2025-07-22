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

- **Backend:** Node.js (Express, MongoDB) _(FastAPI Python baseline included as reference)_
- **Frontend:** React.js
- **DevOps:** GitHub, GitHub Actions, CI/CD, Branch Protection, Code Review

---

## DevOps Practices Implemented

- **Source Control:** All code is versioned in Git and hosted on GitHub.
- **Branching Strategy:** `main` for production, `develop` for integration, feature branches for new work.
- **Branch Protection:**
  - Pull Requests required for merging to `main`.
  - At least one code review required.
  - CI checks must pass before merging.
- **Continuous Integration (CI):**
  - Automated with GitHub Actions.
  - Runs linting and unit tests on every Pull Request.
- **Continuous Delivery (CD):**
  - Project is structured for easy containerization and future cloud deployment.
- **Issue Tracking & Project Board:**
  - All work is tracked via GitHub Issues and a Project Board for visibility and planning.

---

## Local Development Setup

### Backend (Node.js/Express)

1. **Navigate to backend folder:**
   ```bash
   cd backend
   ```
2. **Install dependencies:**
   ```bash
   npm install
   ```
3. **Copy and configure environment variables:**
   ```bash
   cp .env.example .env
   # Edit .env with your MongoDB URI and JWT secret
   ```
4. **Run the backend server:**
   ```bash
   npm run dev
   ```

### Frontend (React)

1. **Navigate to frontend folder:**
   ```bash
   cd frontend
   ```
2. **Install dependencies:**
   ```bash
   npm install
   ```
3. **Run the frontend app:**
   ```bash
   npm start
   ```

### (Legacy/Reference) FastAPI Python Baseline

1. **Install Python dependencies:**
   ```bash
   pip install -r requirements.txt
   ```
2. **Run FastAPI app:**
   ```bash
   uvicorn app.main:app --reload
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
   terraform apply
   ```
   - Review and approve the plan when prompted.
3. **Note the outputs:**
   - ACR login server
   - Postgres connection string
   - Backend app public URL

### 2. Build & Push Docker Image to Azure Container Registry (ACR)

1. **Login to ACR:**
   ```sh
   az acr login --name <acr_name_from_output>
   ```
2. **Build the Docker image:**
   ```sh
   docker build -t <acr_login_server_from_output>/consistly-backend:latest .
   ```
3. **Push the image:**
   ```sh
   docker push <acr_login_server_from_output>/consistly-backend:latest
   ```

### 3. Deploy to Azure Container App

- The Container App is configured to pull the latest image from ACR.
- The backend will be accessible at the public URL output by Terraform.
- Environment variables (like the Postgres connection string) are set automatically.

---

## Testing & Quality

- **Linting:**
  - Python: `flake8`
  - Node.js: `eslint` (to be configured)
- **Unit Testing:**
  - Python: `pytest`
  - Node.js: `jest` (to be configured)
- **CI:** All tests and linters run automatically on Pull Requests.

---

## Contribution

- Fork the repo and create a feature branch from `develop`.
- Open a Pull Request for review and merging.
- All contributions require passing CI and at least one review.

---

## License

MIT
END
