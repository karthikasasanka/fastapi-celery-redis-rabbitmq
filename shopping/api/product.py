from fastapi import APIRouter
import redis

from shopping.config import stages, REDIS_STORE_CONN_URI, STAGING_TIME
from shopping.celery.tasks import move_to_next_stage

redis_store = redis.Redis.from_url(REDIS_STORE_CONN_URI)


product_router = APIRouter()


@product_router.get("/buy/{name}")
async def buy(name: str):
    for i in range(0, 5):
        move_to_next_stage.apply_async((name, stages[i]), countdown=i*STAGING_TIME)
    return True


@product_router.get("/status/{name}")
async def status(name: str):
    return redis_store.get(name)
