#!/bin/bash

DEFAULT_TIME=10
FILE=""
FILE_MD5=""
LOOP=True
COMMAND=nginx
NGINX_CONF=/etc/nginx/conf.d/
RET=""
DEFAULT_FILTER="kind=appsec"

function nginx_exists(){
if ! command -v nginx &> /dev/null
  then
  echo "$COMMAND needs to exists to validate the file"
  exit 1
  fi
}

function filemd5(){
  echo $(md5sum $1 | awk '{print $1}')
}

function nginx_valid_conf(){
  if ! nginx -t &> /dev/null
  then
    echo "Error Validating file by $COMMAND"
    RET=1
  else
    echo "File validation suscess!!!"
    RET=0
  fi
}

function docker_filter_list(){
  Filter=$1
  listId=$(curl --unix-socket /var/run/docker.sock --silent -H "Content-type: application/json" -gG -X GET http://localhost/v1.41/containers/json --data-urlencode 'filters={"label":["'$Filter'"]}'| jq '.[].Id')
  if [[ $(echo "${listId[@]}" | wc -w) == "0" ]]
  then
    echo ""
  else
    echo $listId | sed "s/\"//g" 
  fi
}

function put_file_in_docker(){
  container=$1
  tmp_file=$(mktemp -u)
  TARFILE="$tmp_file.$container.tar"
  tar -cf "$TARFILE" "$FILE"
  echo "TARFILE: $TARFILE"
  curl --unix-socket /var/run/docker.sock -H "Content-Type: application/json" -X PUT "http://localhost/v1.41/containers/$container/archive?path=$NGINX_CONF" --data-binary @$TARFILE
  rm $TARFILE
}

function nginx_restart_signal(){
  container=$1
  EXEC_CREATED=$(curl --silent --unix-socket /var/run/docker.sock -H "Content-Type: application/json" -X POST "http://localhost/v1.41/containers/$container/exec" -d '{"AttachStdout": true, "Tty": true, "Cmd": ["nginx", "-s", "reload"]}' | jq -r '.Id')
  curl --unix-socket /var/run/docker.sock -H "Content-Type: application/json" -X POST "http://localhost/v1.41/exec/$EXEC_CREATED/start" -d '{"Detach": false, "Tty": true}'
}

while getopts "t:f:" options; do
  case "${options}" in
  t)
    DEFAULT_TIME=${OPTARG}
  ;; f) FILE=${OPTARG}
  ;;
  esac
done

##-------- Validation Stuff
if [ -z "$FILE" ]
then
 echo "File is needed to continue"
 exit 0
fi
nginx_exists
#dockerList=$(docker_filter_list "$DEFAULT_FILTER")
##echo "docker list $dockerList"
#for cont in $dockerList
#do
#  #echo "put file in $cont"
#  contname=$(echo $cont | cut -b 1-12)
#  put_file_in_docker $contname
#done
#------ End of validation Stuff
while [ "$LOOP" ]
do
  if [ -z "$FILE_MD5" ]
  then
    echo "first time running obtaining md5"
    nginx_valid_conf
    if [ "$RET" == "0" ]; then
      dockerList=$(docker_filter_list "$DEFAULT_FILTER")
      #echo "docker list $dockerList"
      for cont in $dockerList
      do
        #echo "put file in $cont"
        contname=$(echo $cont | cut -b 1-12)
        put_file_in_docker $contname
        echo "restarting nginx"
        nginx_restart_signal $contname
      done
      FILE_MD5=$(filemd5 $FILE)
      #echo $FILE_MD5
    fi
  else
    NEW_FILE=$(filemd5 $FILE)
    if [ "$NEW_FILE" != "$FILE_MD5" ]
    then
      echo "No son iguales"
      #1 Validar el archivo en el contenedor
      nginx_valid_conf
      if [ "$RET" == "0" ]; then
        dockerList=$(docker_filter_list "$DEFAULT_FILTER")
        #echo "docker list $dockerList"
        for cont in $dockerList
        do
          #echo "put file in $cont"
          contname=$(echo $cont | cut -b 1-12)
          put_file_in_docker $contname
          echo "restarting nginx..."
          nginx_restart_signal $contname
        done
      #2 Si es valido se actualiza el nuevo md5
        FILE_MD5=$NEW_FILE
      #3 si no es valido se descarta y se mantiene el Md5 valido
      fi
    fi
  fi
  sleep $DEFAULT_TIME
done

