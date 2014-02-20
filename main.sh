#!/bin/bash

if [ -f lib/conf ];then
  . lib/conf
else
  echo "not files"
  exit
fi




#tag=$(awk '/http/ {n++}; END {print n+0}' $fini)

function read_conf(){
f=''

  echo "===================="
  echo -e "Select your ini files:\n$(ls sample/ | grep '.ini')\n"
  echo "===================="
  read f
  tmpf=$(mktemp)
  
  if [ "$f" != "" ];then
        
    if [ "$1" == "H" ];then
      http_conf > $tmpf
      read_ini sample/${f} $tmpf
    fi

    if [ "$1" == "N" ];then
      nginx_conf > $tmpf
      read_ini sample/${f} $tmpf
    fi
  else
    rm $tmpf
    echo "===================="
    echo -e "操作錯誤返回主選單:"
    main
    echo "===================="
  fi
  
  rm $tmpf
}


Csed(){
     
  sed -i "s/$1/$2/g" $3 

}

function read_ini(){

fini=$1
fconf=$2
if [ ! -f $fini ];then
  rm $fconf
  echo "===================="
  echo "無效操作返回主選單"
  sleep 1
  main 
fi

    for line in $(cat $fini)
    do
      if [[ $line =~ \[.*\] ]];then
        echo "mk the configuration file"
        f=${line/[}
        dconf=${f/]}.conf
        cp $fconf $dconf
      else
        key=${line/#*=/}   #由前方比對,delete相符合,顯示等於後面的值
        value=${line/%=*/} #由後面比對,delete相符合,顯示等於前面的值
        
        Csed $value $key $dconf
    
        #echo "${value} - ${key}"
          #printf "value : %s\n key : %s" ${value} ${key} 
        fi
    done
}


function main(){
  
  echo -e "|http mod :\t1"
  echo -e "|nginx mod :\t2"
  echo -e "|quit :\t\t3 "
  read -p "選擇你要的模式:" x

  case "$x" in
    1)
      read_conf 'H'
    ;;

    2)
      read_conf 'N'
    ;;

    3)
      exit
    ;;
    *)
      main
    ;;

  esac

  

}

main
