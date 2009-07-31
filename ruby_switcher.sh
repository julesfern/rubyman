# Blatantly cribbed from http://github.com/relevance/etc/blob/3d607c8ac2f76077f27c3cbc0140b04a89f546be/bash/ruby_switcher.sh

# General status
# ------------------------------------------------------------------------

export ORIGINAL_PATH=$PATH
export DEFAULT_RUBY_MAJOR="1.8"
export DEFAULT_RUBY_MINOR="7"
export DEFAULT_RUBY_PATCHLEVEL="72"

function update_path {
 export PATH=$GEM_HOME/bin:$MY_RUBY_HOME/bin:$ORIGINAL_PATH
}

function install_gems {
	mkdir -p ~/tmp &&
	pushd ~/tmp &&
	rm -rf rubygems* &&
	curl -O -L "http://rubyforge.org/frs/download.php/60718/rubygems-1.3.5.tgz" &&
	tar xzf rubygems*.tgz &&
	cd rubygems* &&
	sudo ruby setup.rb &&
	sudo gem sources -a "http://gems.github.com"
}


# MatzRuby Helpers
# ------------------------------------------------------------------------

function install_mri {
  local ruby_major=$1
  local ruby_minor=$2
  local patch_level=$3
  local ruby_version="ruby-$1.$2-p$patch_level"
  local url="ftp://ftp.ruby-lang.org/pub/ruby/$ruby_major/$ruby_version.tar.gz"

  mkdir -p ~/tmp && mkdir -p ~/.ruby_versions && rm -rf ~/.ruby_versions/$ruby_version &&
  pushd ~/tmp &&
  curl -L -O $url &&
  tar xzf $ruby_version.tar.gz &&
  cd $ruby_version &&
  ./configure --prefix=$HOME/.ruby_versions/$ruby_version --enable-shared &&
  make && make install && cd ~/tmp &&
  rm -rf $ruby_version.tar.gz $ruby_version

	use_mri "$1" "$2" "$3"
	install_gems
}

function use_mri {
  local ruby_version="ruby-$1.$2-p$3"
	
	echo "Using Ruby MRI $ruby_version"
	
	export MY_RUBY_HOME=~/.ruby_versions/$ruby_version
	export GEM_HOME=~/.gem/ruby/$1.$2-p$3
	update_path
}

# MacRuby helpers
# ------------------------------------------------------------------------

# JRuby helpers
# ------------------------------------------------------------------------

# RubyEE helpers
# ------------------------------------------------------------------------

# Set default
# ------------------------------------------------------------------------
use_mri "$DEFAULT_RUBY_MAJOR" "$DEFAULT_RUBY_MINOR" "$DEFAULT_RUBY_PATCHLEVEL"
