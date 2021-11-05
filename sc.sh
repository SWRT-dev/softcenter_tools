#!/bin/bash

ARCH=arm64 #bcm490x
#ARCH=arm #bcm470x
#ARCH=armng #bcm675x, ipq4/5/6/80xx, mt7622/3/9
#ARCH=mips #grx500
#ARCH=mipsle #mt7621
PWD=$(pwd)
#prefix asuswrt:/jffs/softcenter,openwrt:/usr

if [ "$ARCH" = "arm" ];then
#armv7l
export CFLAGS="-I $PWD/opt/cross/arm-linux-musleabi/arm-linux-musleabi/include -Os -ffunction-sections -fdata-sections -D_GNU_SOURCE -D_BSD_SOURCE -fPIE"
export CXXFLAGS="-I $PWD/opt/cross/arm-linux-musleabi/arm-linux-musleabi/include"
export CC=$PWD/opt/cross/arm-linux-musleabi/bin/arm-linux-musleabi-gcc
export CXX=$PWD/opt/cross/arm-linux-musleabi/bin/arm-linux-musleabi-g++
export CORSS_PREFIX=$PWD/opt/cross/arm-linux-musleabi/bin/arm-linux-musleabi-
export TARGET_CFLAGS=""
export BOOST_ABI=sysv
elif [ "$ARCH" = "armng" ];then
#armv7l
export CFLAGS="-I $PWD/opt/cross/arm-linux-musleabihf/arm-linux-musleabihf/include -Os -ffunction-sections -fdata-sections -mfpu=neon -mfloat-abi=hard -march=armv7-a -mabi=aapcs-linux -D_GNU_SOURCE -D_BSD_SOURCE -fPIE"
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
export TARGET_CFLAGS=""
export BOOST_ABI=aapcs
elif [ "$ARCH" = "mips" ];then
#mips
export CFLAGS="-I $PWD/opt/cross/mips-linux-musl/mips-linux-musl/include -Os -ffunction-sections -fdata-sections -mno-branch-likely -mtune=1004kc -D_GNU_SOURCE -D_BSD_SOURCE -fPIE"
export CXXFLAGS="-I $PWD/opt/cross/mips-linux-musl/mips-linux-musl/include"
export CC=$PWD/opt/cross/mips-linux-musl/bin/mips-linux-musl-gcc
export CXX=$PWD/opt/cross/mips-linux-musl/bin/mips-linux-musl-g++
export CORSS_PREFIX=$PWD/opt/cross/mips-linux-musl/bin/mips-linux-musl-
export TARGET_CFLAGS=" -DBOOST_NO_FENV_H"
export BOOST_ABI=o32
export mipsarch=" architecture=mips32r2"
elif [ "$ARCH" = "mipsle" ];then
export CFLAGS="-I $PWD/opt/cross/mipsel-linux-musl/mipsel-linux-musl/include -Os -ffunction-sections -fdata-sections -D_GNU_SOURCE -D_BSD_SOURCE -fPIE"
export CXXFLAGS="-I $PWD/opt/cross/mipsel-linux-musl/mipsel-linux-musl/include"
export CC=$PWD/opt/cross/mipsel-linux-musl/bin/mipsel-linux-musl-gcc
export CXX=$PWD/opt/cross/mipsel-linux-musl/bin/mipsel-linux-musl-g++
export CORSS_PREFIX=$PWD/opt/cross/mipsel-linux-musl/bin/mipsel-linux-musl-
export TARGET_CFLAGS=" -DBOOST_NO_FENV_H"
export BOOST_ABI=o32
export mipsarch=" architecture=mips32r2"
fi

BASE=`pwd`
SRC=$BASE/src
WGET="wget --prefer-family=IPv4"
DEST=$BASE/opt
LDFLAGS="-L$DEST/lib -Wl,--gc-sections"
CPPFLAGS="-I$DEST/include"
CXXFLAGS="$CXXFLAGS $CFLAGS"
if [ "$ARCH" = "arm" ];then
CONFIGURE="linux-armv4 -Os -static --prefix=/opt zlib enable-ssl3 enable-ssl3-method enable-tls1_3 --with-zlib-lib=$DEST/lib --with-zlib-include=$DEST/include -DOPENSSL_PREFER_CHACHA_OVER_GCM enable-weak-ssl-ciphers"
ARCHBUILD=arm
elif [ "$ARCH" = "armng" ];then
CONFIGURE="linux-armv4 -Os -static --prefix=/opt zlib enable-ssl3 enable-ssl3-method enable-tls1_3 --with-zlib-lib=$DEST/lib --with-zlib-include=$DEST/include -DOPENSSL_PREFER_CHACHA_OVER_GCM enable-weak-ssl-ciphers"
ARCHBUILD=arm
elif [ "$ARCH" = "arm64" ];then
CONFIGURE="linux-aarch64 -Os -static --prefix=/opt zlib enable-ssl3 enable-ssl3-method enable-tls1_3 --with-zlib-lib=$DEST/lib --with-zlib-include=$DEST/include -DOPENSSL_PREFER_CHACHA_OVER_GCM enable-weak-ssl-ciphers"
ARCHBUILD=aarch64
elif [ "$ARCH" = "mips" ];then
CONFIGURE="linux-mips32 -Os -static --prefix=/opt zlib enable-ssl3 enable-ssl3-method enable-tls1_3 --with-zlib-lib=$DEST/lib --with-zlib-include=$DEST/include -DOPENSSL_PREFER_CHACHA_OVER_GCM enable-weak-ssl-ciphers"
ARCHBUILD=mips
elif [ "$ARCH" = "mipsle" ];then
CONFIGURE="linux-mips32 -Os -static --prefix=/opt zlib enable-ssl3 enable-ssl3-method enable-tls1_3 --with-zlib-lib=$DEST/lib --with-zlib-include=$DEST/include -DOPENSSL_PREFER_CHACHA_OVER_GCM enable-weak-ssl-ciphers"
ARCHBUILD=mipsle
fi
MAKE="make"
mkdir -p bin/$ARCH

######## ####################################################################
# ZLIB # ####################################################################
######## ####################################################################

[ ! -d "zlib-1.2.11" ] && tar xvJf zlib-1.2.11.tar.xz
cd zlib-1.2.11
if [ ! -f "stamp-h1" ];then
CC=${CORSS_PREFIX}gcc \
LDFLAGS=$LDFLAGS \
CPPFLAGS=$CPPFLAGS \
CFLAGS=$CFLAGS \
CXXFLAGS=$CXXFLAGS \
CROSS_PREFIX=${CORSS_PREFIX} \
./configure \
--prefix=/opt \
--static

$MAKE
make install DESTDIR=$BASE
touch stamp-h1
fi

########### #################################################################
# OPENSSL # #################################################################
########### #################################################################

cd $BASE
[ ! -d "openssl-1.1.1d" ] && tar zxvf openssl-1.1.1d.tar.gz
cd $BASE/openssl-1.1.1d
if [ ! -f "stamp-h1" ];then
    if [ ! -e patched ]
    then
        for f in "../patches/"*.patch ; do
            patch -p1 < "$f"
        done
        touch patched
    fi
./Configure $CONFIGURE

make 
make install INSTALLTOP=$DEST OPENSSLDIR=$DEST/ssl
touch stamp-h1
fi

########### #################################################################
##c-ares### #################################################################
########### #################################################################
cd $BASE
[ ! -d "c-ares-1.14.0" ] && tar zxvf c-ares-1.14.0.tar.gz
cd $BASE/c-ares-1.14.0
if [ ! -f "stamp-h1" ];then
./buildconf
CC=${CORSS_PREFIX}gcc \
LDFLAGS=$LDFLAGS" -static" \
CPPFLAGS=$CPPFLAGS \
CFLAGS="-g0 -O2 -Wno-system-headers " \
CXXFLAGS=$CXXFLAGS \
CROSS_PREFIX=${CORSS_PREFIX} \
./configure --prefix=/opt --host=$ARCHBUILD-linux --enable-shared=no --enable-static=yes
make install DESTDIR=$BASE
touch stamp-h1
fi

########### #################################################################
#ZeroTier## #################################################################
########### #################################################################
cd $BASE
[ ! -d "ZeroTierOne-1.4.6" ] && tar zxvf ZeroTierOne-1.4.6.tar.gz
cd $BASE/ZeroTierOne-1.4.6
if [ ! -f "stamp-h1" ];then
if [ ! -f patched ];then
	patch -p1 < ../ZeroTierOne.patch
	touch patched
fi
CC=${CORSS_PREFIX}gcc \
STRIP=${CORSS_PREFIX}strip \
ZT_STATIC=1 \
make
cd $BASE
mkdir -p bin/$ARCH
cp -rf $BASE/ZeroTierOne-1.4.6/zerotier-one bin/$ARCH/zerotier-one
touch stamp-h1
fi

######## ####################################################################
#SC_AUTH ####################################################################
######## ####################################################################
rm -rf sc_auth
$CC -static $CFLAGS $LDFLAGS sc_auth.c ../sc_auth/$ARCH/sc_auth.a -o sc_auth
${CORSS_PREFIX}strip sc_auth
upx --lzma --best sc_auth
cp -f sc_auth ../sc_auth/$ARCH/
