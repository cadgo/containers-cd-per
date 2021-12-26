FROM ubuntu:18.04

# update and install dep
RUN apt update && \
    apt install -y curl gnupg2 apt-transport-https

# install gcloud-sdk
RUN echo "deb http://packages.cloud.google.com/apt cloud-sdk-bionic main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN apt update && apt install -y google-cloud-sdk

# install kubectl
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt update && apt install -y kubectl
RUN mkdir /code
WORKDIR /code
COPY code/ /code
CMD ["bash"]
