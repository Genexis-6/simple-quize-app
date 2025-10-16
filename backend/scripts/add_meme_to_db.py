import uuid
import aiosqlite
import asyncio
import os
from dotenv import load_dotenv


load_dotenv()
DATABASE_PATH = "../data.db"





# a python script to add meme's data to my test database
memes = [
    {
        "meme_text": "70 years old man",
        "person":"Asari Dokubo",
        "audio_file":"70-years-old-man.mp3"
    },
    {
        "meme_text": "There is God o",
        "person":"Patience Jonathan",
        "audio_file":"There-Is-God-O.mp3"
    },
    {
        "meme_text": "They have left you behind",
        "person":"Asari Dokubo",
        "audio_file":"They-av-left-you-behind.mp3"
    },
    {
        "meme_text": "You think say you day wise",
        "person":"Asari Dokubo",
        "audio_file":"you-think-say-you-dey-wise.mp3"
    }
]



async def add_meme():
    try:
        if DATABASE_PATH != "":
            
            async with aiosqlite.connect(DATABASE_PATH) as db:

                # checkes if the table exist then if none, it creates it
                await db.execute(
                    """
                    CREATE TABLE IF NOT EXISTS memes_model(
                        id VARCHAR(50) PRIMARY KEY,
                        person VARCHAR(100), 
                        meme_text VARCHAR(255),
                        audio_file VARCHAR(150)
                    )
                    """ 
                )
                # commit changes
                await db.commit()


                record = [
                     (str(uuid.uuid4()), meme_attr["person"], meme_attr["meme_text"], meme_attr["audio_file"]) for meme_attr in memes
                ]

                await db.executemany(
                    """
                   INSERT INTO memes_model(id, person, meme_text, audio_file) VALUES (?, ?, ?, ?)

                    """, record
                )
                await db.commit()


                print(
                    f"{len(record)} memes has been added to the database"
                )
                await db.close()
        else:
            print("no database url founded")
    except Exception as e:
        print(f"error occured when adding meme due to: {e}")
    
        
        

if __name__ == "__main__":
    asyncio.run(add_meme())