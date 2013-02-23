#!/bin/bash

VERSION_libpcap=1.3.0
URL_libpcap=http://www.tcpdump.org/release/libpcap-$VERSION_libpcap.tar.gz
DEPS_libpcap=()
MD5_libpcap=f78455a92622b7a3c05c58b6ad1cec7e
BUILD_libpcap=$BUILD_PATH/libpcap/$(get_directory $URL_libpcap)
RECIPE_libpcap=$RECIPES_PATH/libpcap

function prebuild_libpcap() {
	true
}

function build_libpcap() {
	cd $BUILD_libpcap

	if [ -f libpcap.a ]; then
		return
	fi

	push_arm

	try ./configure --build=i686-pc-linux-gnu --host=arm-linux-eabi \
		--with-pcap=linux --without-libnl --without-septel --without-snf \
		--without-flex --without-bison
	try make 

	pop_arm
}

function postbuild_libpcap() {
	true
}
