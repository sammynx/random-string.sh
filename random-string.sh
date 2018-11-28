#!/bin/bash

PWLENGTH=16
PWCHARSET='a-zA-Z0-9'

usage () {
	echo "$0 [option]"
	echo '  Generate a random password'
	echo
	echo "option:"
	echo -e "-l, --length\tnumber of characters in password (default: $PWLENGTH)"
	echo -e "-c, --charset\tcharacter set to use for password creation (default: $PWCHARSET)"
	echo -e "-h, --help\tprints this help message"
}

while (( "$#" )); do
	if [[ "$1" == "-l" ]] || [[ "$1" == "--length" ]]; then
		# set length
		PWLENGTH=$2
		shift 2
	elif [[ "$1" == "-c" ]] || [[ "$1" == "--charset" ]]; then
		# set charset
		PWCHARSET=$2
		shift 2
	elif [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
		# print usage information
		usage
		exit 0
	fi
done

PW=$(cat /dev/urandom | tr -dc "$PWCHARSET" | head -c$PWLENGTH)

if [ -t 1 ] ; then
	# connected with terminal
	echo "Creating random password using charset [$PWCHARSET] and length $PWLENGTH"
	echo "$PW"
else
	# connected to a pipe, output clean password
	echo -n "$PW"
fi
