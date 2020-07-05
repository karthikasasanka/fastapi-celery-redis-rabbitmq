FROM python:3.8

ENV REDIS_HOST kredis
ENV REDIS_PORT 6379
ENV REDIS_CELERY_DB_INDEX 10
ENV REDIS_STORE_DB_INDEX 0

ENV RABBITMQ_HOST krabbitmq
ENV RABBITMQ_USERNAME guest
ENV RABBITMQ_PASSWORD guest
ENV RABBITMQ_PORT 5672

COPY ./requirements-api.txt /usr/src/

RUN pip3 install --upgrade pip

RUN pip3 install -r /usr/src/requirements-api.txt

WORKDIR /usr/src

CMD gunicorn --bind 0.0.0.0:5000 shopping.main:app -w 4 -k uvicorn.workers.UvicornWorker --reload --access-logfile - --error-logfile - --log-level info
