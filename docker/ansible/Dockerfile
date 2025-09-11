#AWS ANSIBLE WITH DYNAMIC INVENTORY
FROM python:latest
RUN pip install boto boto3 ansible
RUN ansible-galaxy collection install amazon.aws community.aws
ENV AWS_ACCESS_KEY_ID aaaaa
ENV AWS_SECRET_ACCESS_KEY bbbbb
RUN mkdir /code/
WORKDIR /code
RUN mkdir /etc/ansible/ 
COPY ./playbooks /code
COPY ansible.cfg /etc/ansible
RUN mkdir -p ~/.aws/plugins
RUN bash -c "echo -e \"---\nplugin: aws_ec2\nregions:\n  - us-east-1\" >> ~/.aws/plugins/aws_ec2.yaml"
