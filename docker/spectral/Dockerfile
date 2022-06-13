FROM python
ARG SPEC_URL
RUN curl -L ${SPEC_URL} | sh
RUN mkdir /code
WORKDIR /root 
RUN /root/.spectral/spectral init
COPY spectral.yaml /root/.spectral/
#ENTRYPOINT ["/root/.spectral/spectral","scan", "--include-tags","base,audit,iac"]
