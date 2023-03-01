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
export TARGET_CFLAGS=" -DNDEBUG -DBOOST_NO_FENV_H -DBOOST_DISABLE_ASSERTS"
export BOOST_ABI=aapcs
elif [ "$ARCH" = "armng" ];then
#armv7l
#export CFLAGS="-I $PWD/opt/cross/arm-linux-musleabihf/arm-linux-musleabihf/include -Os -ffunction-sections -fdata-sections -mfpu=neon-vfpv4 -mfloat-abi=hard -ffast-math -fno-finite-math-only -march=armv7-a -mabi=aapcs-linux -D_GNU_SOURCE -D_BSD_SOURCE"
export CFLAGS="-I $PWD/opt/cross/arm-linux-musleabihf/arm-linux-musleabihf/include -Os -ffunction-sections -fdata-sections -mfpu=neon -mfloat-abi=hard -march=armv7-a -mabi=aapcs-linux -D_GNU_SOURCE -D_BSD_SOURCE -fPIE"
export CXXFLAGS="-I $PWD/opt/cross/arm-linux-musleabihf/arm-linux-musleabihf/include"
export CC=$PWD/opt/cross/arm-linux-musleabihf/bin/arm-linux-musleabihf-gcc
export CXX=$PWD/opt/cross/arm-linux-musleabihf/bin/arm-linux-musleabihf-g++
export CORSS_PREFIX=$PWD/opt/cross/arm-linux-musleabihf/bin/arm-linux-musleabihf-
export TARGET_CFLAGS=" -DNDEBUG -DBOOST_DISABLE_ASSERTS"
export BOOST_ABI=aapcs
elif [ "$ARCH" = "arm64" ];then
export CFLAGS="-I $PWD/opt/cross/aarch64-linux-musl/aarch64-linux-musl/include -Os -ffunction-sections -fdata-sections -march=armv8-a -mabi=lp64 -D_GNU_SOURCE -D_BSD_SOURCE -fPIE"
export CXXFLAGS="-I $PWD/opt/cross/aarch64-linux-musl/aarch64-linux-musl/include"
export CC=$PWD/opt/cross/aarch64-linux-musl/bin/aarch64-linux-musl-gcc
export CXX=$PWD/opt/cross/aarch64-linux-musl/bin/aarch64-linux-musl-g++
export CORSS_PREFIX=$PWD/opt/cross/aarch64-linux-musl/bin/aarch64-linux-musl-
export TARGET_CFLAGS=" -DNDEBUG -DBOOST_DISABLE_ASSERTS"
export BOOST_ABI=aapcs
elif [ "$ARCH" = "mips" ];then
#mips
export CFLAGS="-I $PWD/opt/cross/mips-linux-musl/mips-linux-musl/include -Os -ffunction-sections -fdata-sections -mno-branch-likely -mtune=1004kc -D_GNU_SOURCE -D_BSD_SOURCE -fPIE -mips32r2"
export CXXFLAGS="-I $PWD/opt/cross/mips-linux-musl/mips-linux-musl/include"
export CC=$PWD/opt/cross/mips-linux-musl/bin/mips-linux-musl-gcc
export CXX=$PWD/opt/cross/mips-linux-musl/bin/mips-linux-musl-g++
export CORSS_PREFIX=$PWD/opt/cross/mips-linux-musl/bin/mips-linux-musl-
export TARGET_CFLAGS=" -DNDEBUG -DBOOST_NO_FENV_H -DBOOST_DISABLE_ASSERTS"
export BOOST_ABI=o32
export mipsarch=" architecture=mips32r2"
elif [ "$ARCH" = "mipsle" ];then
export CFLAGS="-I $PWD/opt/cross/mipsel-linux-musl/mipsel-linux-musl/include -Os -ffunction-sections -fdata-sections -D_GNU_SOURCE -D_BSD_SOURCE -fPIE -mips32r2"
export CXXFLAGS="-I $PWD/opt/cross/mipsel-linux-musl/mipsel-linux-musl/include"
export CC=$PWD/opt/cross/mipsel-linux-musl/bin/mipsel-linux-musl-gcc
export CXX=$PWD/opt/cross/mipsel-linux-musl/bin/mipsel-linux-musl-g++
export CORSS_PREFIX=$PWD/opt/cross/mipsel-linux-musl/bin/mipsel-linux-musl-
export TARGET_CFLAGS=" -DNDEBUG -DBOOST_NO_FENV_H -DBOOST_DISABLE_ASSERTS"
export BOOST_ABI=o32
export mipsarch=" architecture=mips32r2"
fi
export AR=${CORSS_PREFIX}ar

BASE=`pwd`
SRC=$BASE/src
WGET="wget --prefer-family=IPv4"
DEST=$BASE/opt
LDFLAGS="-L$DEST/lib -Wl,--gc-sections -static"
CPPFLAGS="-I$DEST/include"
CXXFLAGS="$CXXFLAGS $CFLAGS"
CFLAGS="$CFLAGS -static"

MAKE="make -j`nproc`"

######## ####################################################################
# ZLIB # ####################################################################
######## ####################################################################
[ ! -d "cpulimit" ] && tar zxvf cpulimit.tar.gz
cd cpulimit/src
CC=${CORSS_PREFIX}gcc \
LDFLAGS=$LDFLAGS \
CPPFLAGS=$CPPFLAGS \
CFLAGS=$CFLAGS \
CXXFLAGS=$CXXFLAGS \
CROSS_PREFIX=${CORSS_PREFIX} \
$MAKE


cd $BASE
mkdir -p bin/$ARCH
cp -rf cpulimit/src/cpulimit bin/$ARCH
rm -rf cpulimit

done
