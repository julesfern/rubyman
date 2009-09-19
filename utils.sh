#!/bin/bash

# creates or removes and recreates the rubyman tmp dir
function rubyman_utils_create_tmp {
	if [ -d "${RUBYMAN_TMP}" ]; then
		rm -rf ${RUBYMAN_TMP}
	fi
	
	mkdir ${RUBYMAN_TMP}
}

function rubyman_utils_fetch_remote {
	local url=$1
	local output=$2
	local has_curl=0
	local has_wget=0
	
	rubyman_utils_exists "curl" has_curl
	rubyman_utils_exists "wget" has_wget
	
	rubyman_utils_breaker
	echo "Attempting to fetch '${url}' and output as $2"
	
	if [ $has_curl -eq 1 ]; then
		curl -L  -o $2 -O $url
	else
		if [ $has_wget -eq 1 ]; then
			wget $url
		else
			echo "You need either curl or wget to use rubyman to install Ruby from source"
			exit 1
		fi
	fi
	
	rubyman_utils_breaker
}

function rubyman_utils_exists {
	if command -v $1 &>/dev/null; then
		let $2=1
	else
		let $2=0
	fi
}

function rubyman_utils_breaker {
	echo "------------------------------------------------------------------------------------"
}