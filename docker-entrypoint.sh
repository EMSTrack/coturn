#!/bin/bash

set -e
COMMAND=$1

echo $COMMAND

# Run commands
if [ "$COMMAND" = 'up' ];
then

    cat <<EOF >>turnserver.conf
realm=$REALM
fingerprint
external-ip=$PUBLICIP
listening-port=3478
min-port=10000
max-port=20000
log-file=/var/log/turnserver.log
verbose
user=$USERNAME:$PASSWORD
EOF

    echo "> Starting server"
    turnserver -a -c turnserver.conf

else

    echo "> No services started" 
    echo "> Running '$@'"

    exec "$@"

fi
