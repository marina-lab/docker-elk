FROM centos:7.0.1406
MAINTAINER Steffen Prince <steffen@sprin.io>
EXPOSE 5601

RUN yum install -y \
    tar \
    && yum clean all

# Install kibana
RUN curl -O https://download.elasticsearch.org/kibana/kibana/kibana-4.0.1-linux-x64.tar.gz \
    && mkdir /opt/kibana \
    && tar -xzvf ./kibana-4.0.1-linux-x64.tar.gz --strip 1 -C /opt/kibana \
    && rm ./kibana-4.0.1-linux-x64.tar.gz

COPY kibana.yml /etc/kibana/kibana.yml

CMD /opt/kibana/bin/kibana -c /etc/kibana/kibana.yml
