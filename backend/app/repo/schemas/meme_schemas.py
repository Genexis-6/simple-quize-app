from pydantic import BaseModel



class MemeSchemas(BaseModel):
    id:str
    person: str
    meme_text:str
    audio_file:str