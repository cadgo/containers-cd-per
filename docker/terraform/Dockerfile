FROM ubuntu:latest
RUN  apt-get -y update &&  apt-get install -y gnupg software-properties-common curl;\
curl -fsSL https://apt.releases.hashicorp.com/gpg |  apt-key add - ;\
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main";\
apt-get -y update &&  apt-get -y install terraform
WORKDIR /root
