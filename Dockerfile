FROM fedora

RUN dnf -y update

RUN dnf -y install make git

RUN dnf -y install epel-release

RUN git clone https://github.com/ThomasPalma1/linux-environment-ansible-orchestration.git

WORKDIR /linux-environment-ansible-orchestration

RUN make install