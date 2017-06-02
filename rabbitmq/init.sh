#!/bin/sh

# Create Default RabbitMQ setup
( sleep 10 ; \

# Create users
rabbitmqctl add_user inowas_user inowas_password


# Set user rights
rabbitmqctl set_user_tags inowas_user administrator

# Create vhosts
rabbitmqctl add_vhost inowas_vhost

# Set vhost permissions
rabbitmqctl set_permissions -p inowas_vhost inowas_user ".*" ".*" ".*"

) &
rabbitmq-server $@
