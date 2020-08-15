FROM python:3.8

COPY ./shopping/celery /usr/src/shopping/celery

COPY ./shopping/__init__.py /usr/src/shopping/

COPY ./shopping/config.py /usr/src/shopping/

COPY ./requirements-celery.txt /usr/src/

RUN pip3 install --upgrade pip

RUN pip3 install -r /usr/src/requirements-celery.txt

WORKDIR /usr/src

CMD celery worker -A shopping.celery.tasks --loglevel=info
