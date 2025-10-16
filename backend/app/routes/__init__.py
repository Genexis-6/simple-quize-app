from .memes_endpoint import meme_endpoint


def register_all_routes(app):
    app.include_router(meme_endpoint)