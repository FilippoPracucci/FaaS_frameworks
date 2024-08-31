#!/bin/bash

# Help function
Help()
{
    echo
    echo "The script need 3 arguments in this order:"
    echo "1) The name to give to the trigger.
2) The name to assign to the rule.
3) The name of the action to link with the trigger."
    
    echo
    echo "It's possible to give at the end other arguments which will be passed when fire the trigger:
<key> <value>"
    echo
    echo "Options:"
    echo "-h     Print this Help."
    echo
}

# Check options to show help
while getopts "h" option; do
    case $option in
        h) # display Help
            Help
            exit;;
        ?) # incorrect option
            echo "Error: Invalid option"
            exit;;
    esac
done

############################################################################
# Start the script

if [ "$#" -lt 3 ]; then
    echo
    echo -e "Arguments passed are not correct! Arguments required:
1) The name to give to the trigger.
2) The name to assign to the rule.
3) The name of the action to link with the trigger.
    
Arguments optional: parameters to pass when fire the trigger (key value)"
    exit 1
else
    TRIGGER=$1
    RULE=$2
    ACTION=$3

    wsk -i trigger create $TRIGGER
    wsk -i rule create $RULE $TRIGGER $ACTION

    # fire the trigger to test
    if [ "$#" -ne 3 ]; then
        PARAMS=()
        for (( i=4; i<=$#; i++ )); do
            PARAMS+=("${!i}")
        done

        echo "${PARAMS[@]}"
    fi

    wsk -i trigger fire $TRIGGER "${PARAMS[@]}"
fi