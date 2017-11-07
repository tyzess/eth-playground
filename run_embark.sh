if [ "$#" -ne 1 ]
then
  echo "Usage: run_embark [a|b]"
  exit 1
fi

cd ./dapp/demo/embark_demo

embark run privatenet_$1

