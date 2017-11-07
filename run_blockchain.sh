if [ "$#" -ne 1 ]
then
  echo "Usage: run_blockchain [a|b]"
  exit 1
fi

cd ./dapp/demo/embark_demo

embark blockchain privatenet_$1

