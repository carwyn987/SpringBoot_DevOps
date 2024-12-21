#!/bin/bash

# Approach 1 failed from https://www.jenkins.io/doc/book/installing/docker/

docker network create jenkins
#docker run \
#  --name jenkins-docker \
#  --rm \
#  --detach \
#  --privileged \
#  --network jenkins \
#  --network-alias docker \
#  --env DOCKER_TLS_CERTDIR=/certs \
#  --volume jenkins-docker-certs:/certs/client \
#  --volume jenkins-data:/var/jenkins_home \
#  --publish 2376:2376 \
#  docker:dind \
#  --storage-driver overlay2

docker build -t myjenkins-blueocean:2.479.2-1 .
docker run \
  --name jenkins-blueocean \
  --restart=on-failure \
  --detach \
  --network jenkins \
  --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client \
  --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 \
  --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  myjenkins-blueocean:2.479.2-1 


echo "Web server published at localhost:8080"
echo "Attach to the container with \`docker exec -it \<container\> bash\`"
echo "View admin password with \`cat /var/jenkins_home/secrets/initialAdminPassword\`"
