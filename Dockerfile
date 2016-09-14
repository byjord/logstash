FROM logstash
ADD script.sh /
ADD logstash.conf /
ENTRYPOINT /script.sh