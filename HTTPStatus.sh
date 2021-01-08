#!/bin/bash
######################################################################
#           Simple HTTP Status Code Checker                          #
#           Twitter: @HassanAlachek                                  #
#								     #
######################################################################
echo -e "\e[5;31m[*]Check The HTTP Status Code With Curl[*]\e[0m"
count=$(echo $@ |wc -w)
if [ "$count" -le "1" ] || [ "$count" -eq "-h" ]; then
	echo -e "\e[1;32m[?]-h Display Help Menu[?]\e[0m"
	echo -e "\e[1;32m[?]Usage: ./HTTPStatus.sh domains.txt <timeout>[?]\e[0m"
	exit
else 
	echo -e "\e[1;32m[?]-h Display Help Menu[?]\e[0m"
	echo -e "\e[1;32m[?]Usage: ./HTTPStatus.sh domains.txt <timeout>[?]\e[0m"


	for protocol in 'http://' 'https://'; do
		while read url;
		do
			if [ $protocol == 'http://' ]; then
				code=$(timeout $2 curl --write-out "%{http_code}\n" --output /dev/null --silent $protcol$url)
			elif [ $protocol == 'https://' ]; then
				code=$(timeout $2 curl -L --write-out "%{http_code}\n" --output /dev/null --silent --insecure $protcol$url)
			fi
			 
			while read status;
			do
				firstFild=$(echo $status |cut -d " " -f 1)
				if [ "$firstFild" -eq "$code" ]; then
					Description=$(echo $status |cut -d " " -f 2)
					break
				fi
			done < HTTPCode.txt
		
			echo -e "\e[1;97m"$protocol$url"\e[0m""\e[1;36m Staus code: \e[0m""\e[1;33m"$code" "$Description"\e[0m" 
		
		done < $1
	done
fi
