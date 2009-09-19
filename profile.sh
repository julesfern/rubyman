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

function rubyman_profile_slug {
	local profile=$1
	
	mkdir -p $RUBYMAN_HOME/profiles/${profile}
	
	rubyman_switch_profile $profile
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