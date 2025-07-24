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
