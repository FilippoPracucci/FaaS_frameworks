#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo -e "Arguments passed are not correct! Arguments required:
1) The name to give to the function.
2) The language of the function.
3) The registry for the image."
    exit 1
else
    FUNC_NAME=$1
    LANGUAGE=$2
    REGISTRY=$3

    func create -l $LANGUAGE $FUNC_NAME

    cd $FUNC_NAME
    docker login

    echo "options:
  scale:
    metric: rps
    target: 100" >> func.yaml

    func deploy --registry $REGISTRY --build
fi