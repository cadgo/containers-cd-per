FROM python
ARG SPEC_URL
RUN curl -L ${SPEC_URL} | sh
RUN mkdir /code
WORKDIR /code 
ENTRYPOINT ["/root/.spectral/spectral","scan", "--include-tags","base,audit,iac"]
