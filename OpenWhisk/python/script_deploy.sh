#!/bin/bash

if [ "$#" -ne 0 ]; then
    echo -e "Arguments passed are not correct! No arguments required!"
    exit 1
else
    wskdeploy -m python-action.yaml
fi
