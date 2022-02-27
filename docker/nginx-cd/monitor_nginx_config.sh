#!/bin/bash

DEFAULT_TIME=300
FILE=""
FILE_MD5=""
LOOP=True

while getopts "t:f:" options; do
  case "${options}" in
  t)
    DEFAULT_TIME=${OPTARG}
  ;;
  f)
    FILE=${OPTARG}
  ;;
  esac
done

if [ -n "$FILE" ]
then
 echo "File is needed to continue"
 exit 0
fi

while [ "$LOOP" ]
do 
  if [ -n "$FILE_MD5" ] 
  then
    echo "No existe MD5"
    FILE_MD5=$(md5sum $FILE | awk '{print $1}')
    echo $FILE_MD5
  else
    echo "Si Existe MD5"
  fi
  sleep $DEFAULT_TIME
done
