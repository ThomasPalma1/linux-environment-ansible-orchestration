FROM fedora

RUN dnf -y update && \
    dnf -y install make git

RUN git clone https://github.com/ThomasPalma1/linux-environment-ansible-orchestration.git

WORKDIR /linux-environment-ansible-orchestration

RUN make install