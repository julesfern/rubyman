#!/bin/bash

function rubyman_merb_edge_install {
	echo "Installing Merb Edge into the '${RUBYMAN_ACTIVE_PROFILE}' profile"
	
	rubyman_enter_source_install
	
	git clone git://github.com/wycats/merb.git
	
	cd merb
	
	rake install
	
	rubyman_exit_source_install
}