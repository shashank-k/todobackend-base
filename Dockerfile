FROM ubuntu:trusty
ENV TERM=xterm-256color
RUN sed -i "s/http:\/\/archive./http:\/\/in.archive./g" /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y \
    -o APT::Install-Recommend=false -o APT::Install-Suggests=false\
    python python-virtualenv libpython2.7 python-mysqldb
RUN virtualenv /appenv &&\
    . /appenv/bin/activate && \
    pip install pip --upgrade

LABEL application=todobackend

ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

