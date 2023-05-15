FROM python:3.11.3-slim

RUN useradd -ms /bin/bash python

USER python

WORKDIR /home/python/app

CMD [ "tail", "-f", "/dev/null" ]