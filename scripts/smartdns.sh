#!/bin/bash

set -e
set -x

#ARCH=arm64
#ARCH=arm
#ARCH=mips
#ARCH=mipsle
for ARCH in arm mipsle
do
PWD=`pwd`
#prefix asuswrt:/jffs/softcenter,openwrt:/usr
if [ "$ARCH" = "arm" ];then
#armv7l
export CFLAGS="-I $PWD/opt/cross/arm-linux-musleabi/arm-linux-musleabi/include -Os -ffunction-sections -fdata-sections -D_GNU_SOURCE -D_BSD_SOURCE -fPIE"
export CXXFLAGS="-I $PWD/opt/cross/arm-linux-musleabi/arm-linux-musleabi/include"
export CC=$PWD/opt/cross/arm-linux-musleabi/bin/arm-linux-musleabi-gcc
export CXX=$PWD/opt/cross/arm-linux-musleabi/bin/arm-linux-musleabi-g++
export CORSS_PREFIX=$PWD/opt/cross/arm-linux-musleabi/bin/arm-linux-musleabi-
elif [ "$ARCH" = "armng" ];then
#armv7l
#export CFLAGS="-I $PWD/opt/cross/arm-linux-musleabihf/arm-linux-musleabihf/include -Os -ffunction-sections -fdata-sections -mfpu=neon-vfpv4 -mfloat-abi=hard -ffast-math -fno-finite-math-only -march=armv7-a -mabi=aapcs-linux -D_GNU_SOURCE -D_BSD_SOURCE"
export CFLAGS="-I $PWD/opt/cross/arm-linux-musleabihf/arm-linux-musleabihf/include -Os -ffunction-sections -fdata-sections -mfpu=neon -mfloat-abi=hard -march=armv7-a -mabi=aapcs-linux -D_GNU_SOURCE -D_BSD_SOURCE -fPIE"
export CXXFLAGS="-I $PWD/opt/cross/arm-linux-musleabihf/arm-linux-musleabihf/include"
export CC=$PWD/opt/cross/arm-linux-musleabihf/bin/arm-linux-musleabihf-gcc
export CXX=$PWD/opt/cross/arm-linux-musleabihf/bin/arm-linux-musleabihf-g++
export CORSS_PREFIX=$PWD/opt/cross/arm-linux-musleabihf/bin/arm-linux-musleabihf-
elif [ "$ARCH" = "arm64" ];then
export CFLAGS="-I $PWD/opt/cross/aarch64-linux-musl/aarch64-linux-musl/include -Os -ffunction-sections -fdata-sections -march=armv8-a -mabi=lp64 -D_GNU_SOURCE -D_BSD_SOURCE -fPIE"
export CXXFLAGS="-I $PWD/opt/cross/aarch64-linux-musl/aarch64-linux-musl/include"
export CC=$PWD/opt/cross/aarch64-linux-musl/bin/aarch64-linux-musl-gcc
export CXX=$PWD/opt/cross/aarch64-linux-musl/bin/aarch64-linux-musl-g++
export CORSS_PREFIX=$PWD/opt/cross/aarch64-linux-musl/bin/aarch64-linux-musl-
elif [ "$ARCH" = "mips" ];then
#mips
export CFLAGS="-I $PWD/opt/cross/mips-linux-musl/mips-linux-musl/include -Os -ffunction-sections -fdata-sections -mno-branch-likely -mtune=1004kc -D_GNU_SOURCE -D_BSD_SOURCE -fPIE"
export CXXFLAGS="-I $PWD/opt/cross/mips-linux-musl/mips-linux-musl/include"
export CC=$PWD/opt/cross/mips-linux-musl/bin/mips-linux-musl-gcc
export CXX=$PWD/opt/cross/mips-linux-musl/bin/mips-linux-musl-g++
export CORSS_PREFIX=$PWD/opt/cross/mips-linux-musl/bin/mips-linux-musl-
elif [ "$ARCH" = "mipsle" ];then
export CFLAGS="-I $PWD/opt/cross/mipsel-linux-musl/mipsel-linux-musl/include -Os -ffunction-sections -fdata-sections -D_GNU_SOURCE -D_BSD_SOURCE -fPIE"
export CXXFLAGS="-I $PWD/opt/cross/mipsel-linux-musl/mipsel-linux-musl/include"
export CC=$PWD/opt/cross/mipsel-linux-musl/bin/mipsel-linux-musl-gcc
export CXX=$PWD/opt/cross/mipsel-linux-musl/bin/mipsel-linux-musl-g++
export CORSS_PREFIX=$PWD/opt/cross/mipsel-linux-musl/bin/mipsel-linux-musl-
fi

BASE=`pwd`
SRC=$BASE/src
WGET="wget --prefer-family=IPv4"
DEST=$BASE/opt
LDFLAGS="-L$DEST/lib -Wl,--gc-sections"
CPPFLAGS="-I$DEST/include"
CXXFLAGS="$CXXFLAGS $CFLAGS"
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
MAKE="make"

cd $BASE
[ ! -d "zlib-1.2.11" ] && tar xvJf zlib-1.2.11.tar.xz
cd zlib-1.2.11
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

cd $BASE
[ ! -d "openssl-1.1.1l" ] && tar zxvf openssl-1.1.1l.tar.gz
[ ! -d "cryptodev-linux-cryptodev-linux-1.12" ] && tar zxvf cryptodev-linux-1.12.tar.gz && cp -rf $BASE/cryptodev-linux-cryptodev-linux-1.12/crypto $DEST/include
cd $BASE/openssl-1.1.1l
    if [ ! -e patched ]
    then
        for f in "../opensslpatches/"*.patch ; do
            patch -p1 < "$f"
        done
        touch patched
    fi
./Configure $CONFIGURE --cross-compile-prefix=' '

make -j4
make install INSTALLTOP=$DEST OPENSSLDIR=$DEST/ssl

cd $BASE/smartdns/src

export CFLAGS="$CFLAGS -I$DEST/include"
export LDFLAGS="-L$DEST/lib -Wl,--gc-sections"
make
cp -f smartdns smartdns_$ARCH
make clean
cd $BASE
rm -rf openssl-1.1.1l
rm -rf zlib-1.2.11
done
