#!/bin/bash
set -e
set -x

#ARCH=arm64
#ARCH=arm
#ARCH=armng
#ARCH=mips
#ARCH=mipsle
PWD=`pwd`
for ARCH in arm64 arm armng mips mipsle
do
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

BASE=`pwd`
SRC=$BASE/src
WGET="wget --prefer-family=IPv4"
DEST=$BASE/opt
export CPPFLAGS="-I$DEST/include"
export CXXFLAGS="$CXXFLAGS $CFLAGS"
export LDFLAGS="-L$DEST/lib -Wl,--gc-sections -Wl,-rpath,/jffs/softcenter/lib"
# enable-engine disable-dynamic-engine enable-devcryptoeng
if [ "$ARCH" = "arm" ];then
CONFIGURE="linux-armv4 -static --prefix=/jffs/softcenter zlib enable-rc5 enable-ssl3 enable-ssl3-method enable-tls1_3 --with-zlib-lib=$DEST/lib --with-zlib-include=$DEST/include -DOPENSSL_PREFER_CHACHA_OVER_GCM enable-weak-ssl-ciphers no-ssl2 no-gost no-heartbeats no-err no-unit-test no-aria no-sm2 no-sm3 no-sm4 no-tests no-shared no-afalgeng no-async"
ARCHBUILD=arm
elif [ "$ARCH" = "armng" ];then
CONFIGURE="linux-armv4 -static --prefix=/jffs/softcenter zlib enable-rc5 enable-ssl3 enable-ssl3-method enable-tls1_3 --with-zlib-lib=$DEST/lib --with-zlib-include=$DEST/include -DOPENSSL_PREFER_CHACHA_OVER_GCM enable-weak-ssl-ciphers no-ssl2 no-gost no-heartbeats no-err no-unit-test no-aria no-sm2 no-sm3 no-sm4 no-tests no-shared no-afalgeng no-async"
ARCHBUILD=arm
elif [ "$ARCH" = "arm64" ];then
CONFIGURE="linux-aarch64 -static --prefix=/jffs/softcenter zlib enable-rc5 enable-ssl3 enable-ssl3-method enable-tls1_3 --with-zlib-lib=$DEST/lib --with-zlib-include=$DEST/include -DOPENSSL_PREFER_CHACHA_OVER_GCM enable-weak-ssl-ciphers no-ssl2 no-gost no-heartbeats no-err no-unit-test no-aria no-sm2 no-sm3 no-sm4 no-tests no-shared no-afalgeng no-async"
ARCHBUILD=aarch64
elif [ "$ARCH" = "mips" ];then
CONFIGURE="linux-mips32 -static --prefix=/jffs/softcenter zlib enable-rc5 enable-ssl3 enable-ssl3-method enable-tls1_3 --with-zlib-lib=$DEST/lib --with-zlib-include=$DEST/include -DOPENSSL_PREFER_CHACHA_OVER_GCM enable-weak-ssl-ciphers no-ssl2 no-gost no-heartbeats no-err no-unit-test no-aria no-sm2 no-sm3 no-sm4 no-tests no-shared no-afalgeng no-async"
ARCHBUILD=mips
elif [ "$ARCH" = "mipsle" ];then
CONFIGURE="linux-mips32 -static --prefix=/jffs/softcenter zlib enable-rc5 enable-ssl3 enable-ssl3-method enable-tls1_3 --with-zlib-lib=$DEST/lib --with-zlib-include=$DEST/include -DOPENSSL_PREFER_CHACHA_OVER_GCM enable-weak-ssl-ciphers no-ssl2 no-gost no-heartbeats no-err no-unit-test no-aria no-sm2 no-sm3 no-sm4 no-tests no-shared no-afalgeng no-async"
ARCHBUILD=mipsle
fi
MAKE="make -j4"

mkdir -p bin/$ARCH
#$CC -static fuckax3600.c -o fuckax3600
#${CORSS_PREFIX}strip fuckax3600

########### #################################################################
#ZeroTier## #################################################################
########### #################################################################
cd $BASE
[ ! -d "ZeroTierOne-1.10.2" ] && tar zxvf ZeroTierOne-1.10.2.tar.gz
cd $BASE/ZeroTierOne-1.10.2

CC=${CORSS_PREFIX}gcc \
STRIP=${CORSS_PREFIX}strip \
ZT_STATIC=1 \
make
cd $BASE
mkdir -p bin/$ARCH
${CORSS_PREFIX}strip $BASE/ZeroTierOne-1.10.2/zerotier-one
cp -rf $BASE/ZeroTierOne-1.10.2/zerotier-one bin/$ARCH/zerotier-one
rm -rf ZeroTierOne-1.10.2
done
