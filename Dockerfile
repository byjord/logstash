FROM nuagebec/ubuntu:latest

RUN apt-get update && apt-get apt-get install -y --no-install-recommends \
		libzmq3 software-properties-common python3-software-properties python-software-properties \
	&& rm -rf /var/lib/apt/lists/*

RUN add-apt-repository -y ppa:webupd8team/java && apt-get update

RUN apt-get -y install oracle-java8-installer

RUN echo 'deb http://packages.elastic.co/logstash/2.2/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash-2.2.x.list && apt-get update

RUN apt-get install logstash

COPY ./10-syslog-filter.conf /etc/logstash/conf.d/10-syslog-filter.conf
COPY ./30-input-output.conf /etc/logstash/conf.d/30-input-output.conf

RUN service logstash restart
RUN update-rc.d logstash defaults 96 9