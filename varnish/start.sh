#!/bin/bash

chmod +x /etc/varnish/default.vcl

if [ "$WEBSERVER" ] ; then
    sed -i "s/127.0.0.1/$WEBSERVER/g" /etc/varnish/default.vcl
fi

if [ "$WEBSERVER_PORT" ] ; then
    sed -i "s/8080/$WEBSERVER_PORT/g" /etc/varnish/default.vcl
fi

varnishd -f /etc/varnish/default.vcl -s malloc,128M -a 0.0.0.0:80

file_count=0

while [[ $file_count -le 0 ]] ;
do
    file_count=$(find /var/lib/varnish -name _.vsm | wc -l)
    echo "Waiting varnish response..."
    sleep 2
done

echo "Everything ok! Starting log..."

varnishlog