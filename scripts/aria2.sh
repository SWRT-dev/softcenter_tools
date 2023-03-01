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
MAKE="make -j`nproc`"

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
[ ! -d "openssl-1.1.1l" ] && tar zxvf openssl-1.1.1l.tar.gz
[ ! -d "cryptodev-linux-cryptodev-linux-1.12" ] && tar zxvf cryptodev-linux-1.12.tar.gz && cp -rf $BASE/cryptodev-linux-cryptodev-linux-1.12/crypto $DEST/include
cd $BASE/openssl-1.1.1l
if [ ! -f "stamp-h1" ];then
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
touch stamp-h1
fi

########## ##################################################################
# SQLITE # ##################################################################
########## ##################################################################
cd $BASE
[ ! -d "sqlite-autoconf-3081101" ] && tar zxvf sqlite-autoconf-3081101.tar.gz
cd sqlite-autoconf-3081101
if [ ! -f "stamp-h1" ];then
autoreconf -i
LDFLAGS=$LDFLAGS \
CPPFLAGS=$CPPFLAGS \
CFLAGS=$CFLAGS \
CXXFLAGS=$CXXFLAGS \
./configure --host=$ARCHBUILD-linux --prefix=/opt

make
make install DESTDIR=$BASE
touch stamp-h1
fi

########### #################################################################
# LIBXML2 # #################################################################
########### #################################################################
cd $BASE
[ ! -d "libxml2-2.9.3" ] && tar zxvf libxml2-2.9.3.tar.gz
cd libxml2-2.9.3
if [ ! -f "stamp-h1" ];then
LDFLAGS=$LDFLAGS \
CPPFLAGS=$CPPFLAGS \
CFLAGS="" \
CXXFLAGS=$CXXFLAGS \
./configure --host=$ARCHBUILD-linux --prefix=/opt \
 --enable-shared=no \
 --enable-static \
 --with-c14n \
 --without-catalog \
 --without-docbook \
 --with-html \
 --without-ftp \
 --without-http \
 --without-iconv \
 --without-iso8859x \
 --without-legacy \
 --with-output \
 --without-pattern \
 --without-push \
 --without-python \
 --with-reader \
 --without-readline \
 --without-regexps \
 --with-sax1 \
 --with-schemas \
 --with-threads \
 --with-tree \
 --with-valid \
 --with-writer \
 --with-xinclude \
 --with-xpath \
 --with-xptr \
 --with-zlib=$DEST \
 --without-lzma \
 --with-lzma=no

$MAKE LIBS="-lz"
make install DESTDIR=$BASE
touch stamp-h1
fi
########## ##################################################################
# C-ARES # ##################################################################
########## ##################################################################
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
######### ###################################################################
# ARIA2 # ###################################################################
######### ###################################################################
cd $BASE
[ ! -d "aria2-release-1.36.0" ] && tar zxvf aria2-1.36.0.tar.gz
cd aria2-release-1.36.0
autoreconf -i
./configure --host=$ARCHBUILD-linux \
--enable-libaria2 --enable-static --enable-ssl --enable-bittorrent --enable-metalink --enable-websocket --enable-openssl --enable-libxml2 \
--enable-libcares --enable-sqlite3 \
--disable-nls --disable-shared --disable-gnutls --disable-libnettle --disable-libgcrypt --disable-libgmp --disable-libexpat \
--disable-libssh2 \
--without-libuv \
--without-appletls \
--with-xml-prefix=$DEST \
--with-libz \
ZLIB_CFLAGS="-I$DEST/include" \
ZLIB_LIBS="-L$DEST/lib" \
OPENSSL_CFLAGS="-I$DEST/include" \
OPENSSL_LIBS="-L$DEST/lib" \
SQLITE3_CFLAGS="-I$DEST/include" \
SQLITE3_LIBS="-L$DEST/lib" \
LIBCARES_CFLAGS="-I$DEST/include" \
LIBCARES_LIBS="-L$DEST/lib" \
ARIA2_STATIC=yes


echo 0 && sed -i "s/LIBXML2_LIBS = -lxml2 -lz -lm -llzma/LIBXML2_LIBS = -lxml2 -lz -lm/g" src/Makefile && sed -i "s/-lxml2 -lz -lm -llzma/-lxml2 -lz -lm/g" src/Makefile && sed -i "s/LIBXML2_LIBS = -lxml2 -lz -lm -llzma/LIBXML2_LIBS = -lxml2 -lz -lm/g" src/includes/Makefile && sed -i "s/LIBXML2_LIBS = -lxml2 -lz -lm -llzma/LIBXML2_LIBS = -lxml2 -lz -lm/g" Makefile

$MAKE LIBS="-lz -lssl -lcrypto -lsqlite3 -lcares -lxml2"
${CORSS_PREFIX}strip src/aria2c
upx --lzma --best src/aria2c
cd $BASE
mkdir -p bin/$ARCH
cp -rf $BASE/aria2-release-1.36.0/src/aria2c bin/$ARCH
rm -rf zlib-1.2.11
rm -rf openssl-1.1.1l
rm -rf libxml2-2.9.3
rm -rf sqlite-autoconf-3081101
rm -rf c-ares-1.14.0
rm -rf aria2-release-1.36.0
rm -rf $DEST/lib

done
