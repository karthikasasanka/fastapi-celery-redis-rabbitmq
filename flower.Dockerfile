FROM python:3.8

COPY ./shopping/celery /usr/src/shopping/celery

COPY ./shopping/__init__.py /usr/src/shopping/

COPY ./shopping/config.py /usr/src/shopping/

COPY ./requirements-celery.txt /usr/src/

RUN pip3 install --upgrade pip

RUN pip3 install -r /usr/src/requirements-celery.txt

RUN pip3 install flower

WORKDIR /usr/src

CMD celery flower -A shopping.celery.tasks --broker=amqp://${RABBITMQ_USERNAME}:${RABBITMQ_PASSWORD}@${RABBITMQ_HOST}:${RABBITMQ_PORT}//

