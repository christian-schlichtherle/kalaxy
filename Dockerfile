FROM ubuntu:bionic
RUN apt-get update && \
    apt-get install --yes make software-properties-common && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    apt-get install --yes ansible
RUN apt-get install --yes apt-transport-https curl && \
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install --yes kubectl
WORKDIR /workdir
COPY . ./
RUN mv .bashrc .ssh /root && chmod -R go-rwx /root/.ssh
