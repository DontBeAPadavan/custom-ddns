#!/bin/sh

logger -t $(basename $0) "started [$@]"

# WAN action should be up
[ ! "x$1" == "xup" ] && exit 0

PREV_IP_FILE=/etc/storage/prev_ip.txt

# Prev IP file is not exist
[ -e "$PREV_IP_FILE" ] || echo '127.0.0.1' > $PREV_IP_FILE

if [ -z "$3" ]; then
    # This .99 firmware or older, where post_wan_script.sh has no 3rd parameter
    IP=$(ifconfig $2 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
else
    IP=$3
fi

if [ "x$(cat $PREV_IP_FILE)" == "x$IP" ]; then
    logger -t $(basename $0) "ip is not changed."
    exit 0
fi

# User DDNS command should be placed here. Sending SMS is just an example
API_KEY=123ab4cd-56e7-fgh8-909i-8j76543kl210
URL=http://sms.ru/sms/send\?api_id=$API_KEY
NUM=79050123456
TEXT=Новый+IP+роутера+$IP
[ "$(wget -qO - $URL\&to=$NUM\&text=$TEXT | head -n 1)" = "100" ]

if [ $? -eq 0 ];
then
    echo $IP > $PREV_IP_FILE
    logger -t $(basename $0) "update successfull, new IP is $IP"
else
    logger -t $(basename $0) "update failed!"
fi
