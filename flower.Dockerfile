FROM python:3.8

ENV REDIS_HOST kredis
ENV REDIS_PORT 6379
ENV REDIS_CELERY_DB_INDEX 10
ENV REDIS_STORE_DB_INDEX 0

ENV RABBITMQ_HOST krabbitmq
ENV RABBITMQ_USERNAME guest
ENV RABBITMQ_PASSWORD guest
ENV RABBITMQ_PORT 5672

COPY ./shopping/celery /usr/src/shopping/celery

COPY ./shopping/__init__.py /usr/src/shopping/

COPY ./shopping/config.py /usr/src/shopping/

COPY ./requirements-celery.txt /usr/src/

RUN pip3 install --upgrade pip

RUN pip3 install -r /usr/src/requirements-celery.txt

RUN pip3 install flower

WORKDIR /usr/src

CMD celery flower -A shopping.celery.tasks --broker=amqp://${RABBITMQ_USERNAME}:${RABBITMQ_PASSWORD}@${RABBITMQ_HOST}:${RABBITMQ_PORT}//

