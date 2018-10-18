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
        singularity instance.start -B /mnt/ffa91d66-e903-493b-8865-4106decd164c scalable_agent.simg $CONTAINER_NAME
    else
        echo 'Already running.'
    fi

    echo "Connecting."
    singularity shell instance://$CONTAINER_NAME
fi
