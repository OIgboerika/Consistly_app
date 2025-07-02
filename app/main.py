from fastapi import FastAPI
from app.api.v1 import endpoints

app = FastAPI(title="Consistly_app")

app.include_router(endpoints.router) 