FROM python:latest
RUN apt update -y && apt install git
ARG REP=https://github.com/openappsec/waf-comparison-project.git
RUN mkdir /Data; mkdir /git; cd /git; git clone $REP; cd waf-comparison-project;  \
	pip install -r requirements.txt
COPY new_config.py /git/waf-comparison-project/config.py
ENTRYPOINT ["python3", "/git/waf-comparison-project/runner.py"]
