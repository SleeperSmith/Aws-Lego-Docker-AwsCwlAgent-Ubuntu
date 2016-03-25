FROM ubuntu:14.04.4

ADD awslogs-agent-setup.py default.conf init.sh /home/local
RUN apt-get update && \
    apt-get install -y python \
    
RUN python awslogs-agent-setup.py -r {{aws-region}} -c /default.conf -n && \
    rm .\awslogs-agent-setup.py
    
ENTRYPOINT ["/home/local/init.sh"]