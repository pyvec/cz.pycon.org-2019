FROM ubuntu

RUN apt-get update
RUN apt-get -y install curl dirmngr apt-transport-https lsb-release ca-certificates
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs python3 python3-pip python3-psycopg2 python3-pillow python3-tablib

WORKDIR /app
COPY requirements.txt /app
COPY requirements-dev.txt /app

RUN pip3 install -r requirements-dev.txt


