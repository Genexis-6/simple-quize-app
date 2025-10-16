from pydantic import BaseModel



class MemeSchemas(BaseModel):
    person: str
    meme_text:str
    audio_file:str