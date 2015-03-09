==========
docker-elk
==========

These are individually dockerized Elasticsearch, Logstash, and Kibana that are
intended to be used as the basis for a production ELK deployment, as opposed
to an all-in-one ELK image that you would not want to run in production.

What makes this a suitable starting point for a production ELK deploy?

 - Administer and monitor each component individually.
 - Run multiple Elasticsearch nodes for greater capacity, indexing
   throughput, and high availability.
 - Run multiple Logstash nodes for greater log processing throughput and high
   availability.
 - Run multiple Kibana instances for high availability.
 - Centos 7 base image, although this could very easily be adapted to your
   distro of choice.

You are expected to modify or overlay the configuration files to suit your
needs for a production deployment. The included configuration files are
provided for the demonstration.

Demonstration
=============

Build all the images:

.. code::

   docker build -f elasticsearch.Dockerfile -t elasticsearch .
   docker build -f logstash.Dockerfile -t logstash .
   docker build -f kibana.Dockerfile -t kibana .

Run one container each of Elasticsearch, Logstash, and Kibana:

.. code::

   docker run -d --name elasticsearch -p 9200:9200 elasticsearch
   docker run -d --name logstash -p 5000:5000 logstash
   docker run -d --name kibana -p 5601:5601 kibana

The included logstash configuration is taken from the syslog example
from
http://logstash.net/docs/1.4.2/tutorials/getting-started-with-logstash.

To send some syslog messages interactively, we can use:

.. code::

   telnet localhost 5000

Then enter:

.. code::

   Jan 17 2:17:42 mar0 docker[1500]: FATA[0000] Error: attempt to become pid 1 failed.

Your message should now be visible in Kibana. Visit http://localhost:5601, use
the default index pattern of `logstash-*` when prompted, and select
`@timestamp` from "Time-field name". Now visit the "Discover", adjust the
time filter to "Last 1 year", and search for Docker.

TODO
====

 - Run services under non-root user.
 - Demonstrate using data-only container for elasticsearch.
