#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo -e "Arguments passed are not correct! Arguments required:
1) The name to give to the function.
2) The language of the function.
3) The prefix to assign to the image."
    exit 1
else
    FUNC_NAME=$1
    LANGUAGE=$2
    PREFIX=$3
    
    kubectl port-forward -n openfaas svc/gateway 8080:8080 &
    sleep 2

    mkdir $FUNC_NAME
    cd $FUNC_NAME

    PASSWORD=$(kubectl get secret -n openfaas basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode; echo)
    faas-cli login --username admin --password $PASSWORD
    docker login

    faas-cli new $FUNC_NAME --lang $LANGUAGE --prefix $PREFIX
    faas-cli up -f $FUNC_NAME.yml
fi
