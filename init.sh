#!/bin/bash

set -e

echo "Starting SSH ..."
/usr/sbin/sshd

java -Dserver.port=80 -jar /app.jar