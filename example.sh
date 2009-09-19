#!/bin/bash

function rubyman_new_profile {
	rubyman_profile_slug "example"
	
	#rubyman_ruby_install "1.8" "7" "72"
	#rubyman_ruby_install_gems "1.3" "5" 

	rubyman_gem_install "merb"
}