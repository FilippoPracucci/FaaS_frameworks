#!/bin/bash

if [ "$#" -ne 0 ]; then
    echo -e "Arguments passed are not correct! No arguments required!"
    exit 1
else
    faas-cli build -f node-function.yml
    faas-cli deploy -f node-function.yml
fi
