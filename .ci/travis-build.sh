#!/bin/sh

set -e

#if OS is linux or is not set
if [ "$TRAVIS_OS_NAME" = linux -o -z "$TRAVIS_OS_NAME" ]; then
    mkdir build 
    cd build
    cmake -DNON_INTERACTIVE_BUILD:BOOL=TRUE ..
    make -k
elif [ "$TRAVIS_OS_NAME" = osx ]; then
    mkdir build
    cd build
    cmake -DNON_INTERACTIVE_BUILD:BOOL=TRUE ..
    make 
    cd ..
    if [ "OSX_GENERATOR" = Xcode ]; then 
        mkdir build_xcode 
        cd build_xcode
        cmake -DNON_INTERACTIVE_BUILD:BOOL=TRUE .. -GXcode
        xcodebuild
    fi
fi
