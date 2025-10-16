from fastapi import FastAPI
import contextlib
from app.repo import db_session_manager
from app.routes import register_all_routes



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

register_all_routes(app)


@app.get("/")
async def welcome():
    
    return "api running"