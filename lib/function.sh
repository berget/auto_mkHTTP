#! -*-Shell-script-*-


#載入文件
. ./conf

BOOTUP=color
RES_COL=60
MOVE_TO_COL="echo -en \\033[${RES_COL}G"
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_WARNING="echo -en \\033[1;33m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"


echo_success() {
  [ "$BOOTUP" = "color" ] && $MOVE_TO_COL
  echo -n "["
  [ "$BOOTUP" = "color" ] && $SETCOLOR_SUCCESS
  echo -n $"  OK  "
  [ "$BOOTUP" = "color" ] && $SETCOLOR_NORMAL
  echo -n "]"
  echo -ne "\r"
  return 0
}

ccho_failure() {
  [ "$BOOTUP" = "color" ] && $MOVE_TO_COL
  echo -n "["
  [ "$BOOTUP" = "color" ] && $SETCOLOR_FAILURE
  echo -n $"FAILED"
  [ "$BOOTUP" = "color" ] && $SETCOLOR_NORMAL
  echo -n "]"
  echo -ne "\r"
  return 1
}

echo_passed() {
  [ "$BOOTUP" = "color" ] && $MOVE_TO_COL
  echo -n "["
  [ "$BOOTUP" = "color" ] && $SETCOLOR_WARNING
  echo -n $"PASSED"
  [ "$BOOTUP" = "color" ] && $SETCOLOR_NORMAL
  echo -n "]"
  echo -ne "\r"
  return 1
}

echo_warning() {
  [ "$BOOTUP" = "color" ] && $MOVE_TO_COL
  echo -n "["
  [ "$BOOTUP" = "color" ] && $SETCOLOR_WARNING
  echo -n $"WARNING"
  [ "$BOOTUP" = "color" ] && $SETCOLOR_NORMAL
  echo -n "]"
  echo -ne "\r"
  return 1
}

function show_IP(){
  IP=ifconfig | grep "inet addr:" | grep -v '127.0.0.1' | cut -d":" -f2 | awk '{print $1}')
  return $IP
}


function  tagUser(){
  local user=$USER
  local date=$(date +%y%m%d-%H%M)
  
  echo "# 建立者: $user"
  echo "# 建立時間: $date"


}
function Csed(){
  sed -i "s/$1/$2/g" $3

}

# 建立config檔
function new_config(){
   local line=
   local tmpF=
   local newF=
   
   INIf=$1
    
  for line in $(cat $INIf)
  do
    if [[ $line =~ \[.*\] ]]; then
      tmpF=${line/[}
      newF=${tmpF/]}.conf
      echo "$newF" 
      http_conf > $newF && echo_success

    else
      value=${line/%=*/}
      key=${line/#*=/}
      if [ ${key}x != ""x ]; then
        Csed $value $key $newF
      fi
    fi

  done

}

