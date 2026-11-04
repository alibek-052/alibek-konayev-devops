#!/usr/bin/env bash
# Builds and starts Jenkins in a container (needs Docker on the host).
set -e
cd "$(dirname "$0")"

docker build -t jenkins-docker .
docker rm -f jenkins 2>/dev/null || true
docker run -d --name jenkins --restart unless-stopped -u root \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins-docker

echo "Jenkins is starting: open http://localhost:8080"
echo "(GitHub Codespaces: tab PORTS -> port 8080 -> open in browser)"
echo "Waiting for the initial admin password..."
until docker exec jenkins test -f /var/jenkins_home/secrets/initialAdminPassword 2>/dev/null; do
  sleep 2
done
echo "Initial admin password:"
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
