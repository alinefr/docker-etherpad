FROM node:0.10
MAINTAINER Aline Freitas <aline@alinefreitas.com.br>

RUN apt-get update && \
    apt-get install -y gzip git curl python libssl-dev mysql-client && \
    rm -r /var/lib/apt/lists/*

RUN cd /opt && \
    git clone https://github.com/ether/etherpad-lite && \
    cd etherpad-lite && \
    bin/installDeps.sh && \
    rm settings.json

COPY entrypoint.sh /entrypoint.sh
VOLUME /opt/etherpad-lite/var

RUN ln -s /opt/etherpad-lite/var/settings.json /opt/etherpad-lite/settings.json && \
    ln -s /opt/etherpad-lite/var/package.json /opt/etherpad-lite/package.json && \
    npm install

WORKDIR /opt/etherpad-lite
EXPOSE 9001
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bin/run.sh", "--root"]
