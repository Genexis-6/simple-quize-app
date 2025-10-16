from fastapi import APIRouter
from app.repo import db_injection
from app.repo.schemas.default_response_schemas import DefaultResponseSchemas
from app.repo.schemas.meme_schemas import MemeSchemas
from app.repo.queries.meme_queries import MemeQueries
from typing import List
from fastapi.exceptions import HTTPException

meme_endpoint = APIRouter(
    prefix="/meme",
    tags=["memes"],
    responses={
        404:{
            "message": "not fund"
        }
    }
)



@meme_endpoint.get("/", response_model=DefaultResponseSchemas[List[MemeSchemas]])
async def get_all_memes(db: db_injection):
    meme_query = MemeQueries(db)
    try:
        get_memes = await meme_query.get_all_memes()
        return DefaultResponseSchemas(
            statusCode=200,
            message="all memes",
            data=get_memes
        )
    except Exception as e:
        raise HTTPException(
            detail=f"error getting memes due to: {e}",
            status_code=500
        )