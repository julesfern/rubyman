#!/bin/bash

function rubyman_profile_create {
	local config_file=$2
	local config_path=""
	
	if [[ $config_file == *http://* ]]; then
		echo "Fetching remote profile configuration ..."
		
		rubyman_enter_source_install
		
		rubyman_utils_fetch_remote $config_file "profile.sh"
		
		rubyman_exit_source_install
		
		$config_file="profile.sh"
		$config_path="$RUBYMAN_TMP/profile.sh"
	fi
	
	echo "Creating profile with configuration: ${config_file}"
	
	source $config_file

	# run the install from the config
	rubyman_new_profile
}

function rubyman_profile_name {
	local profile=$1
	local slug=$2
	
	mkdir -p $RUBYMAN_HOME/profiles/${profile}

	if [ "$slug" ]; then
		ln -s $RUBYMAN_HOME/profiles/${profile} $RUBYMAN_HOME/profiles/${slug}
	fi

	rubyman_switch_profile $profile
}

function rubyman_profile_find_slug {
	local profile=$1
	
	export RUBYMAN_LAST_DIR=`pwd`
	
	pushd $RUBYMAN_HOME/profiles >> /dev/null
	
	for f in `ls`
	do
		local link=`rubyman_utils_readlink $f`
		
		if [ "$link" = "$RUBYMAN_HOME/profiles/$profile" ]; then
			echo "$f"
			
			return 0
		fi
	done
	
	pushd $RUBYMAN_LAST_DIR >> /dev/null
	
	return 1
}

function rubyman_profile_info {
	local profile=0
	
	if [ -n $2 ]; then
		profile=$RUBYMAN_ACTIVE_PROFILE
	else
		profile=$2
	fi
	
	local profile_slug=`rubyman_profile_find_slug $profile`
	
	rubyman_utils_breaker
	
	if [ ! -n $RUBYMAN_ACTIVE_PROFILE ]; then
		echo "Active profile: $RUBYMAN_ACTIVE_PROFILE"
	else
		echo "Active profile: currently not in use"
	fi
	
	rubyman_utils_breaker
	
	if [ -d "$RUBYMAN_ACTIVE_PROFILE_DIR" ]; then
		echo "Name: $profile"
		echo "Slug: $profile_slug"
		
		local binaries="Binaries:"
		
		for f in `ls ${RUBYMAN_HOME}/profiles/${profile}/bin`
		do
			binaries="$binaries $f,"
		done
	
		echo "$binaries"
	else
		echo "The profile '${profile}' does not exist in rubyman"
	fi
	
	rubyman_utils_breaker
}

function rubyman_profile_use {
	rubyman_switch_profile $2
	
	# check for gem updates here?
}

function rubyman_profile_rename {
	local profile_name = $1
	local new_profile_name = $2
	
	mv $RUBYMAN_HOME/profiles/$profile_name $RUBYMAN_HOME/profiles/$new_profile_name
}

function rubyman_profile_delete {
	local profile_name = $1
	
	rm -rf $RUBYMAN_HOME/profiles/$profile_name
}