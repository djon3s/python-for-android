#!/bin/bash

# REPLACE ALL THE "tor" OF THIS FILE WITH THE MODULE NAME
# THEN REMOVE THIS ERROR AND EXIT
#error "not configure" && exit -1

# version of your package
VERSION_tor=0.2.3.25

# dependencies of this recipe
DEPS_tor=(openssl libevent) #perhaps add zlib if this doesn't work

# url of the package
URL_tor=https://www.torproject.org/dist/tor-0.2.3.25.tar.gz

# md5 of the package
MD5_tor=a1c364189a9a66ed9daa8e6436489daf

# default build path
BUILD_tor=$BUILD_PATH/tor/$(get_directory $URL_tor)

# default recipe path
RECIPE_tor=$RECIPES_PATH/tor

# function called for preparing source code if needed
# (you can apply patch etc here.)
function prebuild_tor() {
	true
}

# function called to build the source code
function build_tor() {
	cd $BUILD_tor
	
	push_arm
	
	try ./configure --host=arm-linux-eabi --build=x86_64
	try make -C external
	try make
	
	pop_arm
}

# function called after all the compile have been done
function postbuild_tor() {
	true
}
