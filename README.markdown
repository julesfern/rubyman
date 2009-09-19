Rubyman (Projectman Edition)
============================

A shared problem
----------------
Long have been the days since all Ruby developers lived in the same, gigantic house - wallowed in the same filth, drank the same flat soda. Once a common brotherhood, now a fractured land of lost souls shouting gibberish at each other. "I'm working on a few apps at the same time," they scream, "but they've all got problems with different ruby versions! And not all gems work in all Ruby environments! What am I to do? Ruby development has become a hassle!"

IT IS _NOT_ A HASSLE!
---------------------
With this patented set of scripts mostly cobbled together from other scripts found on github, you'll be able to manage multiple Ruby revisions like a pro, even running different patchlevels of the same Ruby version alongside each other. Each Ruby version even gets its own Rubygems installation. Experience anal retentive gem management on a level *never before experienced*. After mere minutes of using this script, most developers gain the ability to *eat sharks and other large marine wildlife*.

The coder's lament!
-------------------
A common complaint about multiruby systems is that they are *too automatic* and *not at all fussy enough about patchlevels*. With this set of scripts, you'll be painfully aware of every single teensy itty-bitty revision and update to your favourite scripting language.

Installing
==========

	git clone git://github.com/danski/rubyman.git ~/.rubyman
	echo "source ~/rubyman/rubyman.sh" >> ~/.bash_profile

Using it
========

Installing `profile` configurations
-----------------------------------

	rubyman install myprofile.sh
	
Rubyman also supports installing remote `profile` configurations, you can specify a remote URL in place of a file. 

Note: bash scripts could be used to cause damage to your computer's data, only install a configuration from a trusted source.
	
Using a `profile`
-----------------

	rubyman use myprofileslug
	
Removing a `profile`
--------------------

	rubyman delete myprofileslug
	
Creating a `profile` configuration
----------------------------------

A Rubyman `profile` configuration is a simple bash script;

	#!/bin/bash

	function rubyman_new_profile {
		# sets the profile slug for this configuration
		rubyman_profile_slug "myprofileslug"

		# installs Ruby 1.8.7p72
		rubyman_ruby_install "1.8" "7" "72"

		# installs RubyGems 1.3.5
		rubyman_ruby_install_gems "1.3" "5" 

		# installs Merb
		rubyman_gem_install "merb"

		# installs Datamapper 0.10.0
		rubyman_gem_install "dm-core" "0.10.0"
	}