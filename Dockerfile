FROM ubuntu
USER root

FROM python:3.7.0-slim
WORKDIR /app
RUN mkdir /tmp/sync
RUN mkdir /root/.ssh
#Assumes Dockerfile is located inside published output directory
COPY . .
RUN apt-get update && apt-get install rsync ssh -y

#SSH - This is to facilitate execution of rsync command
RUN sed -i 's/prohibit-password/yes/' /etc/ssh/sshd_config
RUN echo "StrictHostKeyChecking=no" >> /etc/ssh/ssh_config
RUN chmod 600 sample_file_server.pem

RUN /etc/init.d/ssh start

ENTRYPOINT ["python", "sync_file.py"]

#============================================================================


