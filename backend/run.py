from app.config import main_config
import uvicorn


if __name__ == "__main__":
    uvicorn.run(
        app=main_config.APP_NAME,
        port=main_config.PORT,
        reload=main_config.RELOAD,
        host=main_config.HOST
    )