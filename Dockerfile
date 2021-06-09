FROM amd64/ubuntu:focal

RUN apt-get update && \
    apt-get install -y lib32z1 xinetd && \
    useradd -m ctf && \
    cp -dR /usr/lib* /home/ctf && \
    mkdir /home/ctf/dev && \
    mknod /home/ctf/dev/null c 1 3 && \
    mknod /home/ctf/dev/zero c 1 5 && \
    mknod /home/ctf/dev/random c 1 8 && \
    mknod /home/ctf/dev/urandom c 1 9 && \
    chmod 666 /home/ctf/dev/* && \
    mkdir /home/ctf/bin

COPY ./ctf.xinetd /etc/xinetd.d/ctf
COPY ./start.sh /start.sh
COPY ./catflag /home/ctf/bin/sh
COPY ./catflag /home/ctf/bin/bash

RUN touch /home/ctf/bin/pwn && \
    chmod +x /home/ctf/bin/pwn && \
    chmod +x /home/ctf/bin/sh && \
    chmod +x /home/ctf/bin/bash && \
    chmod +x /start.sh && \
    chown -R root:ctf /home/ctf && \
    chmod -R 750 /home/ctf && \
    echo "Blocked by ctf_xinetd" > /etc/banner_fail

WORKDIR /home/ctf/bin

ENTRYPOINT ["/start.sh"]

EXPOSE 9999
