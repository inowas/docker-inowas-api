#!/bin/sh
set -e

echo ">> Waiting for RabbitMQ to start"
WAIT=0
while ! nc -z rabbitmq 5672; do
  sleep 1
  echo "   RabbitMQ not ready yet"
  WAIT=$(($WAIT + 1))
  if [ "$WAIT" -gt 60 ]; then
    echo "Error: Timeout when waiting for RabbitMQ socket"
    exit 1
  fi
done

echo ">> RabbitMQ socket available, resuming command execution"
echo ">> Wait for another 10 seconds until rabbitMQ-setup is really finished and all users are registered"

sleep 10

"$@"