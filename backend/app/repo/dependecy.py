from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine, async_sessionmaker
from sqlalchemy.orm import declarative_base
from app.config import main_config
import contextlib
from typing import AsyncIterable

DATABASE_URL:str = main_config.DATABASE_URL
Base = declarative_base()


class DbSessionManager:
    def __init__(self, host:str):
        self.__engine = create_async_engine(url=host)
        self.__session_maker = async_sessionmaker(
            bind=self.__engine, connect_agrs = {"check_same_thread": False}
        )
        
    async def start(self):
        if self.__engine is None:
            raise Exception("No host provided for the db session manager")
        async with self.__engine.begin() as conn:
            await conn.run_sync(Base.metadata.create_all)
    
    async def end(self):
        if self.__engine is None:
            raise Exception("No host provided for the db session manager at the start")
        await self.__engine.dispose()
        self.__engine = None
        self.__session_maker = None
        
    @contextlib.asynccontextmanager
    async def session(self) -> AsyncIterable[AsyncSession]:
        if self.__session_maker is None:
            raise Exception("session maker was not initialized correctly")
        session = self.__session_maker()
        try:
            yield session
        except Exception as e:
            print(f"error occured in session due to: {e}")
            await session.rollback()
            raise
        finally:
            await session.close()
            
            
            
            

db_session_manager = DbSessionManager(
    host=DATABASE_URL
)
         
            
    