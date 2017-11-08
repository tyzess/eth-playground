#!/bin/bash
dapp_path="./dapp_js/*"

preload_list=""

for f in $dapp_path
do
  f=`realpath $f`
  echo "preload: $f"
  preload_list=$preload_list$f","
done


preload_cmd=""
if [ -n "$preload_list" ]; then    
    preload_list=${preload_list::-1} #remove last character
    preload_cmd='--preload "'$preload_list'" '
fi


exec_cmd=""
if [ -n "$1" ]; then  
    exec_cmd=" --exec \""$1"\""
fi

cmd="geth $preload_cmd $exec_cmd attach ipc:\"./geth.ipc\""
echo $cmd
eval $cmd


