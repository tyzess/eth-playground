#!/bin/bash
dapp_path="../dapp/"

while [ $# -gt 0 ]
do
  import_dir="dapp_js"
  rm -r -f $import_dir
  mkdir $import_dir
  import_path=$dapp_path$1"/dist/contracts/*"
  echo $import_path
	for f in $import_path
	do
	  # take action on each file. $f store current file name
	  basename=`basename $f`          
          basename=`echo $basename | sed "s/\.json//g"`
          basename=`echo $basename | tr '[:upper:]' '[:lower:]'`

          json_object=$basename"_json"
	  contract_object=$basename
          
	  content=`tr '\n' ' ' < $f`
	  json_block=$json_object"="$content
          contract_block=$contract_object"=eth.contract("$json_object".abi).at("$json_object".address)"     

          js_path=$import_dir"/"$json_object".js"
          echo "Create import JS $js_path file..."
          
	  echo $json_block"; "$contract_block";" > $js_path
	done
  shift
done
