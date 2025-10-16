from ..dependecy import AsyncSession
from sqlalchemy import select
from ..models.memes_model import MemesModel
from ..schemas.meme_schemas import MemeSchemas


class MemeQueries:
    def __init__(self, db: AsyncSession):
        self.__db = db
        
    
    
    async def get_all_memes(self):
        res = await self.__db.execute(select(MemesModel))
        results = res.scalars().all()
        if results:
            return [
                MemeSchemas(
                    person= result.person, 
                    audio_file=result.audio_file,
                    meme_text=result.meme_text
                    
                )
                for result in results
            ]
        return []
        