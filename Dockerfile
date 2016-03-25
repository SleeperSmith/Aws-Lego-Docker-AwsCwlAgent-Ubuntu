FROM ubuntu:14.04.4

ADD awslogs-agent-setup.py default.conf init.sh /home/local/
RUN apt-get update && \
    apt-get install -y python curl
    
RUN python /home/local/awslogs-agent-setup.py \
        -r {{aws-region}} \
        -c /home/local/default.conf \
        -n && \
    service awslogs stop
RUN rm /home/local/awslogs-agent-setup.py && \
    rm /var/log/awslogs.log

RUN chmod +x /home/local/init.sh
VOLUME ["/var/awslogs/state/"]

ENTRYPOINT ["/home/local/init.sh"]
