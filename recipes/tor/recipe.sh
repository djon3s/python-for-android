#!/bin/bash

# REPLACE ALL THE "TOR" OF THIS FILE WITH THE MODULE NAME
# THEN REMOVE THIS ERROR AND EXIT
#error "not configure" && exit -1

# version of your package
VERSION_TOR=0.2.3.25

# dependencies of this recipe
DEPS_TOR=(openssl libevent) #perhaps add zlib if this doesn't work

# url of the package
URL_TOR=https://www.torproject.org/dist/tor-0.2.3.25.tar.gz

# md5 of the package
MD5_TOR=a1c364189a9a66ed9daa8e6436489daf

# default build path
BUILD_TOR=$BUILD_PATH/TOR/$(get_directory $URL_TOR)

# default recipe path
RECIPE_TOR=$RECIPES_PATH/TOR

# function called for preparing source code if needed
# (you can apply patch etc here.)
function prebuild_TOR() {
	true
}

# function called to build the source code
function build_TOR() {
	cd $BUILD_TOR
	
	push_arm
	
	try ./configure --host=arm-linux-eabi --build=x86_64
	try make -C external
	try make
	
	pop_arm
}

# function called after all the compile have been done
function postbuild_TOR() {
	true
}
