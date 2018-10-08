FROM ubuntu:16.04

MAINTAINER michalszalkowski.com

RUN apt-get update && \
    apt-get install -y git  && \
    apt-get install -y wget && \
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

# arachni
RUN wget https://github.com/Arachni/arachni/releases/download/v1.5.1/arachni-1.5.1-0.5.12-linux-x86_64.tar.gz && \
        tar xzvf arachni-1.5.1-0.5.12-linux-x86_64.tar.gz > /dev/null && \
        mv arachni-1.5.1-0.5.12 /usr/local && \
        ln -s /usr/local/arachni-1.5.1-0.5.12/bin/* /usr/local/bin/

# sslyze
RUN python -m pip install --upgrade pip && \
    pip install --upgrade setuptools && \
    pip install --upgrade sslyze

# zap
RUN apt-get install -y default-jre && \
    wget -O zap.tar.gz https://github.com/zaproxy/zaproxy/releases/download/2.7.0/ZAP_2.7.0_Core.tar.gz && \
    tar -xzf zap.tar.gz && \
    echo 'cd /ZAP_2.7.0 && java -jar zap-2.7.0.jar $@' > /usr/local/bin/zap && \
    chmod +x /usr/local/bin/zap

RUN echo '#!/usr/bin/env bash \neval $1' > /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]