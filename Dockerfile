FROM amd64/ubuntu:focal

# ENV DEBIAN_FRONTEND noninteractive
# ENV TV Asia/Shanghai
RUN apt-get update 
# apt-get install -y tzdata
# ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
# dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install -y lib32z1 xinetd
#  vim curl inetutils-ping net-tools dnsutils

RUN useradd -m ctf

RUN cp -dR /usr/lib* /home/ctf

RUN mkdir /home/ctf/dev && \
    mknod /home/ctf/dev/null c 1 3 && \
    mknod /home/ctf/dev/zero c 1 5 && \
    mknod /home/ctf/dev/random c 1 8 && \
    mknod /home/ctf/dev/urandom c 1 9 && \
    chmod 666 /home/ctf/dev/*

RUN mkdir /home/ctf/bin && \
    cp /bin/ls /home/ctf/bin && \
    cp /bin/cat /home/ctf/bin

COPY ./ctf.xinetd /etc/xinetd.d/ctf
COPY ./start.sh /start.sh
COPY ./catflag /home/ctf/bin/sh

RUN touch /home/ctf/bin/pwn && \
    chmod +x /home/ctf/bin/pwn && \
    chmod +x /home/ctf/bin/sh
RUN echo "Blocked by ctf_xinetd" > /etc/banner_fail

RUN chmod +x /start.sh

RUN chown -R root:ctf /home/ctf && \
    chmod -R 750 /home/ctf

WORKDIR /home/ctf/bin

ENTRYPOINT ["/start.sh"]

EXPOSE 9999
