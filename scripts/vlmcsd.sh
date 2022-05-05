#!/bin/bash

#ARCH=arm64
#ARCH=arm
#ARCH=armng
#ARCH=mips
#ARCH=mipsle
for ARCH in mips mipsle armng arm arm64
do
PWD=$(pwd)
#prefix asuswrt:/jffs/softcenter,openwrt:/usr

if [ "$ARCH" = "arm" ];then
#armv7l
export CFLAGS="-I $PWD/opt/cross/arm-linux-musleabi/arm-linux-musleabi/include -Os -ffunction-sections -fdata-sections -D_GNU_SOURCE -D_BSD_SOURCE -fPIE"
export CXXFLAGS="-I $PWD/opt/cross/arm-linux-musleabi/arm-linux-musleabi/include"
export CC=$PWD/opt/cross/arm-linux-musleabi/bin/arm-linux-musleabi-gcc
export CXX=$PWD/opt/cross/arm-linux-musleabi/bin/arm-linux-musleabi-g++
export CORSS_PREFIX=$PWD/opt/cross/arm-linux-musleabi/bin/arm-linux-musleabi-
export READELF=$PWD/opt/cross/arm-linux-musleabi/bin/arm-linux-musleabi-readelf
export TARGET_CFLAGS=""
export BOOST_ABI=sysv
elif [ "$ARCH" = "armng" ];then
#armv7l
export CFLAGS="-I $PWD/opt/cross/arm-linux-musleabihf/arm-linux-musleabihf/include -Os -ffunction-sections -fdata-sections -marm -march=armv7-a -mabi=aapcs-linux -mfpu=neon -mfloat-abi=hard -D_GNU_SOURCE -D_BSD_SOURCE -fPIE"
export CXXFLAGS="-I $PWD/opt/cross/arm-linux-musleabihf/arm-linux-musleabihf/include"
export CC=$PWD/opt/cross/arm-linux-musleabihf/bin/arm-linux-musleabihf-gcc
export CXX=$PWD/opt/cross/arm-linux-musleabihf/bin/arm-linux-musleabihf-g++
export CORSS_PREFIX=$PWD/opt/cross/arm-linux-musleabihf/bin/arm-linux-musleabihf-
export TARGET_CFLAGS=""
export BOOST_ABI=sysv
elif [ "$ARCH" = "arm64" ];then
export CFLAGS="-I $PWD/opt/cross/aarch64-linux-musl/aarch64-linux-musl/include -Os -ffunction-sections -fdata-sections -march=armv8-a -mabi=lp64 -D_GNU_SOURCE -D_BSD_SOURCE -fPIE"
export CXXFLAGS="-I $PWD/opt/cross/aarch64-linux-musl/aarch64-linux-musl/include"
export CC=$PWD/opt/cross/aarch64-linux-musl/bin/aarch64-linux-musl-gcc
export CXX=$PWD/opt/cross/aarch64-linux-musl/bin/aarch64-linux-musl-g++
export CORSS_PREFIX=$PWD/opt/cross/aarch64-linux-musl/bin/aarch64-linux-musl-
export READELF=$PWD/opt/cross/aarch64-linux-musl/bin/aarch64-linux-musl-readelf
export TARGET_CFLAGS=""
export BOOST_ABI=aapcs
elif [ "$ARCH" = "mips" ];then
#mips
export CFLAGS="-I $PWD/opt/cross/mips-linux-musl/mips-linux-musl/include -Os -ffunction-sections -fdata-sections -D_GNU_SOURCE -D_BSD_SOURCE -fPIE -mips32r2 -mno-branch-likely -mtune=1004kc"
export CXXFLAGS="-I $PWD/opt/cross/mips-linux-musl/mips-linux-musl/include"
export CC=$PWD/opt/cross/mips-linux-musl/bin/mips-linux-musl-gcc
export CXX=$PWD/opt/cross/mips-linux-musl/bin/mips-linux-musl-g++
export CORSS_PREFIX=$PWD/opt/cross/mips-linux-musl/bin/mips-linux-musl-
export READELF=$PWD/opt/cross/mips-linux-musl/bin/mips-linux-musl-readelf
export TARGET_CFLAGS=" -DBOOST_NO_FENV_H"
export BOOST_ABI=o32
export mipsarch=" architecture=mips32r2"
elif [ "$ARCH" = "mipsle" ];then
export CFLAGS="-I $PWD/opt/cross/mipsel-linux-musl/mipsel-linux-musl/include -Os -ffunction-sections -fdata-sections -D_GNU_SOURCE -D_BSD_SOURCE -fPIE -mips32r2"
export CXXFLAGS="-I $PWD/opt/cross/mipsel-linux-musl/mipsel-linux-musl/include"
export CC=$PWD/opt/cross/mipsel-linux-musl/bin/mipsel-linux-musl-gcc
export CXX=$PWD/opt/cross/mipsel-linux-musl/bin/mipsel-linux-musl-g++
export CORSS_PREFIX=$PWD/opt/cross/mipsel-linux-musl/bin/mipsel-linux-musl-
export READELF=$PWD/opt/cross/mipsel-linux-musl/bin/mipsel-linux-musl-readelf
export TARGET_CFLAGS=" -DBOOST_NO_FENV_H"
export BOOST_ABI=o32
export mipsarch=" architecture=mips32r2"
fi
export AR=${CORSS_PREFIX}ar

BASE=`pwd`
SRC=$BASE/src
WGET="wget --prefer-family=IPv4"
DEST=$BASE/opt
LDFLAGS="-L$DEST/lib -Wl,--gc-sections"
CPPFLAGS="-I$DEST/include"
CXXFLAGS="$CXXFLAGS $CFLAGS"

########### #################################################################
##json-c ## #################################################################
########### #################################################################
cd $BASE
[ ! -d "vlmcsd-svn1113" ] && unzip vlmcsd-svn1113.zip -d vlmcsd-svn1113
cd $BASE/vlmcsd-svn1113/vlmcsd-svn1113

MAKE="make" 
export CFLAGS="$CFLAGS -static"
export LDFLAGS="$LDFLAGS -static"
$MAKE all
cd $BASE
mkdir -p bin/$ARCH
cp -rf $BASE/vlmcsd-svn1113/vlmcsd-svn1113/bin/vlmcsd bin/$ARCH
rm -rf $BASE/vlmcsd-svn1113
done
