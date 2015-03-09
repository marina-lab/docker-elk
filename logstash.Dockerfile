FROM centos:7.0.1406
MAINTAINER Steffen Prince <steffen@sprin.io>
EXPOSE 5000

RUN yum install -y \
    tar \
    java-1.7.0-openjdk \
    && yum clean all

# Install logstash
RUN curl -O https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz \
    && mkdir /opt/logstash \
    && tar -xzvf ./logstash-1.4.2.tar.gz --strip 1 -C /opt/logstash \
    && rm ./logstash-1.4.2.tar.gz

# Install contrib plugins
RUN /opt/logstash/bin/plugin install contrib

COPY logstash.conf /etc/logstash/logstash.conf

CMD /opt/logstash/bin/logstash -f /etc/logstash/logstash.conf
