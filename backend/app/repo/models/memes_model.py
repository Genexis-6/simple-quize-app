from ..dependecy import Base
from sqlalchemy import UUID, String, DateTime
import uuid
from sqlalchemy.orm import Mapped, mapped_column
 

class MemesModel(Base):
    __tablename__ = "memes_model"
    id:Mapped[UUID] = mapped_column(UUID, default=uuid.uuid4(), primary_key=True, index=True)
    person:Mapped[str] = mapped_column(String(100), index=True)
    meme_text:Mapped[str] = mapped_column(String(255), index=True)
    audio_file:Mapped[str] = mapped_column(String(150), index=True)
   