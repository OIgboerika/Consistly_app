FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ ./app

CMD python -m uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-8000}
