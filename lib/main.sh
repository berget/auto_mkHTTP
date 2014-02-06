#!/bin/bash

: << EEEEE
declare -i i sum
for ((i=0;i<2;i=i+1))
do

 
 read -p "select type nginx/http" DN

 n[$i]=$DN
 echo "x[${i}]: "${n[$i]}
 
done


nginx(){
  echo "is nginx function"
  echo "Make File $(date +%y%m%d_)nginx.ini"
    
   
}

EEEEE


. function.sh


tagUser
new_config $1
#for line in $(cat $1)
#do
#  if [[ $line =~ \[.*\] ]]; then
#    tmpF=${line/[}
#    newF=${tmpF/]}
#  else
#    value=${line/%=*/}
#    key=${line/#*=/}
#    if [ ${key}x != ""x ]; then
#
#      echo -e "value: ${value}\n key: ${key}"
#    fi
#  fi
#
#
#done
exit 1
