from .dependecy import db_session_manager, AsyncSession
from fastapi import Depends
from typing import Annotated



# register model here
from .models.memes_model import MemesModel



async def get_db():
    async with db_session_manager.session() as session:
        yield session
        
        

db_injection = Annotated[AsyncSession, Depends(get_db)]