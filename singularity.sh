#!/bin/bash

CONTAINER_NAME='gnets'

count=`singularity instance.list | grep $CONTAINER_NAME | wc -l | xargs`
if [ "$1" == "stop" ]; then
    if [[ $count -eq 1 ]]; then        
        singularity instance.stop $CONTAINER_NAME
    else
        echo 'No container running.'
    fi
else

    if [[ $count -eq 0 ]]; then
        echo 'No instance running, starting new one.'
        # at present set SINGULARITY_BINDPATH to specify mount points
        singularity instance.start $CONTAINER_NAME.simg $CONTAINER_NAME
    else
        echo 'Already running.'
    fi

    echo "Connecting."
    singularity shell instance://$CONTAINER_NAME
fi
