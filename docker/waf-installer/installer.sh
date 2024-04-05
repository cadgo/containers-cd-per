#!/bin/bash 

PACKAGES="git tmux"

LOGFILE=install.log
PKG = "vim git curl"

logger(){
  d_format="+%F %T"
  lstring="$(date "$d_format") $@"

  echo $lstring >> $LOGFILE
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

logger "hola mundo"
