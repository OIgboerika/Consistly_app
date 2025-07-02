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
