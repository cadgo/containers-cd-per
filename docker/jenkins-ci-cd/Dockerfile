#https://hub.docker.com/r/bitnami/jenkins
FROM bitnami/jenkins:latest
USER 0
RUN mkdir /bad_images; mkdir /code; mkdir /shiftleft
COPY ./shiftleft_bin /shiftleft
RUN chmod +x /shiftleft/shiftleft
ENV PATH /shiftleft:/opt/bitnami/common/bin:/opt/bitnami/java/bin:/opt/bitnami/git/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
COPY /images /bad_images
RUN git clone https://github.com/cadgo/CloudGuard-ShiftLeft-CICD.git /code
RUN chown 1001:1001 /bad_images/*
USER 1001
