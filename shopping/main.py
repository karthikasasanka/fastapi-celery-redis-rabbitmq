
from fastapi import FastAPI
from shopping.api.product import product_router


app = FastAPI(title="Shop API", docs_url="/", version="1.0.0")

app.include_router(
    product_router,
    prefix="/product",
    tags=["Product"],
)


