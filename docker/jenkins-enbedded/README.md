# Jenkins dockerized for labs

The image is intent to run Jenkins and run docker commands to use spectral and shiftleft and scan the build process

docker run -it -p 8080:8080 -p 50000:50000 -v /var/run/docker.sock:/var/run/docker.sock -v jenkins_home:/var/jenkins_home custom-jenkins-docker
