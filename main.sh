#!/bin/bash


fini=x.ini
fconf=sample.conf


#tag=$(awk '/http/ {n++}; END {print n+0}' $fini)


Csed(){
     
  sed -i "s/$1/$2/g" $3 

}



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
  



