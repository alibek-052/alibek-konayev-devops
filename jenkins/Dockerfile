# Jenkins with the Docker CLI inside, so pipelines can run "docker build / run"
FROM jenkins/jenkins:lts
USER root
RUN apt-get update \
 && apt-get install -y --no-install-recommends lsb-release curl ca-certificates \
 && curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc https://download.docker.com/linux/debian/gpg \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends docker-ce-cli \
 && rm -rf /var/lib/apt/lists/*
# Lab setup only: we stay root so Jenkins may use /var/run/docker.sock
