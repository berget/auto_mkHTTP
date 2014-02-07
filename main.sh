#!/bin/bash

if [ -f lib/conf ];then
  . lib/conf
else
  echo "not files"
  exit
fi




#tag=$(awk '/http/ {n++}; END {print n+0}' $fini)

function read_conf(){
  echo "Select your ini files:\n$(ls | grep '.ini')\n"
  read -p "..." f
  tmpf=$(mktemp)
  

  if [ "$1" == "H" ];then
    http_conf > $tmpf
    read_ini $f $tmpf
  fi

  if [ "$1" == "N" ]; then
    nginx_conf > $tmpf
    read_ini $f $tmpf
  fi
  
  rm $tmpf
}


Csed(){
     
  sed -i "s/$1/$2/g" $3 

}

function read_ini(){

fini=$1
fconf=$2

    for line in $(cat $fini)
    do
      if [[ $line =~ \[.*\] ]];then
        echo "mk the configuration file"
        f=${line/[}
        dconf=${f/]}.conf
        cp $fconf $dconf
      else
        key=${line/#*=/}
        value=${line/%=*/}
        
        Csed $value $key $dconf
    
        #echo "${value} - ${key}"
          #printf "value : %s\n key : %s" ${value} ${key} 
        fi
    done
}


function main(){
    
  read -p "H | N | quit" x

  case "$x" in
    'H')
      read_conf 'H'
    ;;

    'N')
      read_conf 'N'
    ;;

    'quit'|'q')
      exit
    ;;
    *)
      main
    ;;

  esac

  

}

main
