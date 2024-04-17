#!/bin/bash 

PACKAGES="git tmux"

LOGFILE=install.log
PKG="vim git curl"
DM=http://carlosdiazgonzalez.info

logger(){
  d_format="+%F %T"
  lstring="$(date "$d_format") [$0] $@"

  echo $lstring >> $LOGFILE
}

docker_build_run(){
  logger "changing domain $DM inside config.py"
  cat config.py | sed -e 's/\(http\|https\)\:\/\/testdomain\.info/$DM/g' > new_config.py
  logger "buildikg image"
  docker build -t waf-comparison .
  docker run -d waf-comparison
  logger "Removing new_config"
  rm new_config.py
}

install_core_comp(){
  logger "updating virtual machine"
  apt update -y 
  logger "installing base pkg"
  apt install -y $PKG
}

install_docker(){
  logger "Installin docker"
  apt-get install -y ca-certificates curl gnupg lsb-release
  mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  apt update -y
  apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose
}

if (( $EUID != 0 )); then
  logger "Not running as Root"
  echo "This script needs run as Root"
  exit
fi
install_core_comp
install_docker
docker_build_run
