FROM fedora:latest

RUN yum -y update

RUN yum -y install make git

RUN yum -y install wget

RUN git clone https://github.com/ThomasPalma1/linux-environment-ansible-orchestration.git

WORKDIR /linux-environment-ansible-orchestration

RUN make install
