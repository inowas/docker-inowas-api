#!/bin/sh

# Read env-variables
RABBITMQ_USER=${RABBITMQ_DEFAULT_USER:-inowas_user}
RABBITMQ_PASSWORD=${RABBITMQ_DEFAULT_PASS:-inowas_password}
RABBITMQ_VIRTUAL_HOST=${RABBITMQ_DEFAULT_VHOST:-inowas_vhost}

echo RABBITMQ_USER: ${RABBITMQ_USER}
echo RABBITMQ_PASSWORD: ${RABBITMQ_PASSWORD}
echo RABBITMQ_VIRTUAL_HOST: ${RABBITMQ_VIRTUAL_HOST}

# Create Default RabbitMQ setup
( sleep 10 ; \

# Create users
rabbitmqctl add_user ${RABBITMQ_USER} ${RABBITMQ_PASSWORD}


# Set user rights
rabbitmqctl set_user_tags ${RABBITMQ_USER} administrator

# Create vhosts
rabbitmqctl add_vhost ${RABBITMQ_VIRTUAL_HOST}

# Set vhost permissions
rabbitmqctl set_permissions -p ${RABBITMQ_VIRTUAL_HOST} ${RABBITMQ_USER} ".*" ".*" ".*"

) &
rabbitmq-server $@
