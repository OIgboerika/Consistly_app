from fastapi import FastAPI
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(title="Consistly API", version="1.0.0")

@app.on_event("startup")
async def startup_event():
    logger.info("Starting Consistly API...")

@app.get('/')
def root():
    logger.info("Root endpoint accessed")
    return {'message': 'Welcome to Consistly API'}


@app.get('/health')
def health():
    logger.info("Health check endpoint accessed")
    return {'status': 'healthy'}
