#!/bin/sh

############## HEARTBEAT TEST ###########
if [ -z "$HEARTBEATSTEP"]; then
        echo "La variable d'environnement HEARTBEATSTEP doit être valuée !";
        return 1;
fi

while true;
do 
        echo $1 \($(date +%H:%M:%S)\);
        sleep "$HEARTBEATSTEP";
done
