#!/bin/bash
VERSION_libdnet=1.12
URL_libdnet=https://libdnet.googlecode.com/files/libdnet-$VERSION_libdnet.tgz
DEPS_libdnet=
MD5_libdnet=9253ef6de1b5e28e9c9a62b882e44cc9
BUILD_libdnet=$BUILD_PATH/libdnet/$(get_directory $URL_libdnet)
RECIPE_libdnet=$RECIPES_PATH/libdnet

function prebuild_libdnet() {
	cd $BUILD_libdnet

	# check marker in our source build
	if [ -f .patched ]; then
		# no patch needed
		return
	fi

	try patch -p0 < $RECIPE_libdnet/patches/pyrex-errno-header.diff

	touch .patched

}

function build_libdnet() {
	cd $BUILD_libdnet

	push_arm
	#try ./configure --host=arm-linux-eabi --with-python=$BUILD_PATH/python-install/bin/python.host
	try ./configure --host=arm-linux-eabi
	try make 

	export LDFLAGS="$LDFLAGS -L$LIBS_PATH"

	cd python
	try find . -iname '*.pyx' -exec cython {} \; # may not strictly be necessary
	try $BUILD_PATH/python-install/bin/python.host setup.py install

	pop_arm
}

function postbuild_libdnet() {
	true
}
