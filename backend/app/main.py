from fastapi import FastAPI
import contextlib
from app.repo import db_session_manager


@contextlib.asynccontextmanager
async def lifespan(app):
    # create all models if not exist in db
    await db_session_manager.start()
    yield
    await db_session_manager.end()

# api entry point
app = FastAPI(
    title="quize app api"
    ,lifespan= lifespan
)

@app.get("/")
async def welcome():
    return "api running"