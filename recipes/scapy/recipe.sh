#!/bin/bash
VERSION_scapy=
URL_scapy=http://www.secdev.org/projects/scapy/files/scapy-latest.tar.gz
DEPS_scapy=(python hostpython pypcap libdnet)
MD5_scapy=357b5b21ea3b4f289a326c0905b715c1
BUILD_scapy=$BUILD_PATH/scapy/$(get_directory $URL_scapy)
RECIPE_scapy=$RECIPES_PATH/scapy

function prebuild_scapy() {
#	cd $BUILD_scapy
#
#	# check marker in our source build
#	if [ -f .patched ]; then
#		# no patch needed
#		return
#	fi
#
#	try patch -p0 < $RECIPE_scapy/patches/pyrex-errno-header.diff
#
#	touch .patched

	true
}

function build_scapy() {
	cd $BUILD_scapy

	push_arm
	try $BUILD_PATH/python-install/bin/python.host setup.py install
	pop_arm
}

function postbuild_scapy() {
	true
}
