#!/bin/bash


sudo apt-get update

sudo apt-get install -y wget

## erlang version pinning
echo "#/etc/apt/preferences.d/erlang
Package: erlang*
Pin: version 1:19.3-1
Pin-Priority: 1000
Package: esl-erlang
Pin: version 1:19.3.6
Pin-Priority: 1000" > /etc/apt/preferences.d/erlang


echo 'deb http://www.rabbitmq.com/debian/ testing main' | sudo tee /etc/apt/sources.list.d/rabbitmq.list


wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -




sudo apt-cache policy

## install rabbitmq server
sudo apt-get install -y rabbitmq-server

## adding new rabbitmq user
rabbitmqctl add_user test test

rabbitmqctl set_user_tags test administrator

rabbitmqctl set_permissions -p / test ".*" ".*" ".*"

 cd /usr/lib/rabbitmq/lib/rabbitmq_server-*/plugins/

wget https://bintray.com/rabbitmq/community-plugins/download_file?file_path=rabbitmq_delayed_message_exchange-0.0.1.ez

## rename the downloaded file
mv download_file?file_path=rabbitmq_delayed_message_exchange-0.0.1.ez rabbitmq_delayed_message_exchange-0.0.1.ez

chmod 775 rabbitmq_delayed_message_exchange-0.0.1.ez

sudo rabbitmq-server start  &
## sleep 5 sec
sleep 5
## enable the plugin
sudo  rabbitmq-plugins enable rabbitmq_delayed_message_exchange
sudo rabbitmq-plugins enable rabbitmq_management
