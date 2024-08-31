#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo -e "
Arguments passed are not correct! Arguments required:

1) The name to give to the action.
2) The path to the handler file."
    exit 1
else
    ACTION_NAME=$1
    FILE=$2
    PATH_TO_FILE=$(dirname "$FILE")
    FILENAME="${FILE#"$PATH_TO_FILE"/}"

    cd $PATH_TO_FILE
    wsk -i action create $ACTION_NAME $FILENAME
    wsk -i action invoke $ACTION_NAME --result

    # Create file .yaml to deploy
    touch $ACTION_NAME.yaml
    echo "packages:
    default:
        actions:
            $ACTION_NAME:
                function: $FILENAME" > $ACTION_NAME.yaml

    wskdeploy -m $ACTION_NAME.yaml
fi
