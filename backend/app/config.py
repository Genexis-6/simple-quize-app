from pydantic_settings import BaseSettings, SettingsConfigDict
from dotenv import load_dotenv

load_dotenv()

class MainConfig(BaseSettings):
    DATABASE_URL:str
    APP_NAME:str
    PORT:int
    RELOAD:bool
    ANDROIDHOST:str
    HOST:str
    
    
    

main_config = MainConfig()