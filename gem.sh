#!/bin/bash

function rubyman_gem_install {
	local name=$1
	local version=$2
	local cmd="install $name"
	
	if [ ! -n "$version" ]; then
		cmd="$cmd"
	else
		cmd="$cmd -v $version"
	fi
	
	$RUBYMAN_ACTIVE_PROFILE_DIR/bin/gem $cmd
}
