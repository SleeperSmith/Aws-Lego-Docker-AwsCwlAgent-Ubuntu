FROM ubuntu:14.04.4

ADD awslogs-agent-setup.py default.conf init.sh /home/local/
RUN apt-get update && \
    apt-get install -y python
    
RUN python /home/local/awslogs-agent-setup.py \
        -r {{aws-region}} \
        -c /home/local/default.conf \
        -n && \
    service awslogs stop
RUN rm .\awslogs-agent-setup.py && \
    rm /var/log/awslogs.log && \
    rm /var/awslog/state/agent-state
    
ENTRYPOINT ["/home/local/init.sh"]