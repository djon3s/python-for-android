#!/bin/bash

# version of your package
VERSION_txtorcon=

# dependencies of this recipe
DEPS_txtorcon=(tor twisted)

# url of the
URL_txtorcon=https://github.com/meejah/txtorcon/archive/3b370a0cc77ee7c52fcd956611c5aed244c19a96.zip

# md5 of the package
MD5_pylibpd=

# default build path
BUILD_pylibpd=$BUILD_PATH/txtorcon/$(get_directory $URL_txtorcon)

# default recipe path
RECIPE_txtorcon=$RECIPES_PATH/txtorcon

# function called for preparing source code if needed
# (you can apply patch etc here.)
function prebuild_txtorcon() {
	true
}

# function called to build the source code
function build_txtorcon() {
    cd $BUILD_txtorcon
    push_arm
    try $BUILD_PATH/python-install/bin/python.host setup.py install -O2
    pop_arm
}

# function called after all the compile have been done
function postbuild_txtorcon() {
	true
}
