#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo -e "Arguments passed are not correct! Arguments required:
The registry for the image."
    exit 1
else
    REGISTRY=$1

    func deploy --registry $REGISTRY --build
fi
