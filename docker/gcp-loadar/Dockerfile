FROM python:latest
RUN pip install -r requeriments.txt
ENV D9_API_KEY aaaaaaaaaaa
ENV D9_API_SECRET bbbbbbbbbbb
RUN mkdir /code/
WORKDIR /code
COPY gcp-onboard.py /code
