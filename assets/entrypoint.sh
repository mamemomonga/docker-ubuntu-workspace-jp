#!/bin/bash
set -eu

function do_init {
 	if [ -z "$(cat /etc/group | awk -F: '{print $3}' | grep $UBUNTU_GID)" ]; then
 		groupadd -g $UBUNTU_GID ubuntu
 	fi
 	if [ -z "$(cat /etc/passwd | awk -F: '{print $3}' | grep $UBUNTU_UID)" ]; then
 		useradd -g $UBUNTU_GID -u $UBUNTU_UID -s /bin/bash ubuntu
 	fi
	if [ ! -e /etc/sudoers.d/wheel_user ]; then
		echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/wheel_user
		chmod 600 /etc/sudoers.d/wheel_user
	fi
	tar cC /etc/skel . | gosu ubuntu tar xkC /home/ubuntu || true
	echo
	echo
}

function server_stop {
	echo ""
	echo "SERVER STOP"
	exit 0
}

function server_start {
	echo "SERVER START"
	sleep infinity & wait
}

do_init
trap server_stop TERM
server_start

