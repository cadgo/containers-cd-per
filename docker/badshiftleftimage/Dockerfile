FROM ubuntu:latest
RUN mkdir /code
RUN apt -y update; apt -y install wget git
RUN git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git /code
WORKDIR /code
