# Consistly_app

Consistly_app is a baseline FastAPI application designed for professional DevOps practices, including CI/CD, containerization, and infrastructure as code.

## Features

- FastAPI web framework
- Automated linting and testing via GitHub Actions
- Ready for containerization and cloud deployment

## Local Setup

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd Consistly_app
   ```
2. **Create a virtual environment:**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```
3. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```
4. **Run the application:**
   ```bash
   uvicorn app.main:app --reload
   ```
5. **Run tests:**
   ```bash
   pytest
   ```
# Trigger CI
