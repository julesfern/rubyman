#!/bin/bash

function rubyman_gem_install {
	local name=$1
	local version=$2
	local src=$3
	local params=$4
	local cmd="install $name"
	
	if [ ! -n "$version" ]; then
		cmd="$cmd"
	else
		cmd="$cmd -v $version"
	fi
	
	if [ ! -n "$src" ]; then
		cmd="$cmd"
	else
		cmd="$cmd -s $src"
	fi
	
	if [ ! -n "$params" ]; then
		cmd="$cmd"
	else
		cmd="$cmd -- $params"
	fi
	
	$RUBYMAN_ACTIVE_PROFILE_DIR/bin/gem $cmd
}

function rubyman_gem_update {
	local name=$1
	local version=$2
	local cmd="update"
	
	if [ ! -n "$name" ]; then
		cmd="$cmd"
	else
		cmd="$cmd $name"
	fi
	
	if [ ! -n "$version" ]; then
		cmd="$cmd"
	else
		cmd="$cmd -v $version"
	fi
	
	$RUBYMAN_ACTIVE_PROFILE_DIR/bin/gem $cmd
}

function rubyman_gem_uninstall {
	local name=$1
	local version=$2
	local cmd="uninstall"
	
	if [ ! -n "$name" ]; then
		cmd="$cmd"
	else
		cmd="$cmd $name"
	fi
	
	if [ ! -n "$version" ]; then
		cmd="$cmd"
	else
		cmd="$cmd -v $version"
	fi
	
	$RUBYMAN_ACTIVE_PROFILE_DIR/bin/gem $cmd
}