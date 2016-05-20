FROM nginx:1.9.9

# upgrade
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends python-pip wget unzip && \
    rm -rf /var/lib/apt/lists/* && \
    pip install envtpl

# nginx
ADD nginx.conf.tpl /etc/nginx/nginx.conf.tpl

# run script
ADD ./run.sh ./run.sh

# head
RUN wget "https://github.com/mobz/elasticsearch-head/archive/master.zip" && \
    unzip -d /tmp/ master.zip && mv "/tmp/elasticsearch-head-master" /head

# logs
VOLUME ["/var/log/nginx"]

# ports
EXPOSE 80 443

ENTRYPOINT ["/run.sh"]
