FROM python:3.8

COPY ./requirements-api.txt /usr/src/

RUN pip3 install --upgrade pip

RUN pip3 install -r /usr/src/requirements-api.txt

WORKDIR /usr/src

CMD gunicorn --bind 0.0.0.0:5000 shopping.main:app -w 4 -k uvicorn.workers.UvicornWorker --reload --access-logfile - --error-logfile - --log-level info
