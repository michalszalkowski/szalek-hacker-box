FROM ubuntu:16.04

MAINTAINER michalszalkowski.com

RUN apt-get update && \
    apt-get install -y git  && \
    apt-get install -y python-pip && \
    apt-get install -y sqlmap && \
    apt-get install -y nmap

# xsssniper
RUN cd /home && \
    pip install mechanize && \
    pip install lxml && \
    git clone https://github.com/gbrindisi/xsssniper.git && \
    cd /home/xsssniper && \
    ln -sf /home/xsssniper/xsssniper.py /usr/local/bin/xsssniper

RUN echo '#!/usr/bin/env bash \neval $1' > /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]