if [ $# -lt 2 ] ; then
    echo "./install_oprofile.sh <cross-copile> <endianess(lil/big)>"
    echo "example: ./install_oprofile.sh mipsel-rt3052-linux-gnu lil"
    exit
fi

echo $(pwd)
PREFIX=$(pwd)/install
cd libnet
ac_cv_libnet_endianess=$2 ac_libnet_have_pf_packet=yes LL_INT_TYPE=libnet_link_linux ./configure  --program-prefix= --program-suffix= --prefix=$PREFIX --exec-prefix=$PREFIX --bindir=$PREFIX/bin --sbindir=$PREFIX/sbin --libexecdir=$PREFIX/lib --sysconfdir=$PREFIX/etc --datadir=$PREFIX/share --localstatedir=$PREFIX/var --mandir=$PREFIX/man --infodir=$PREFIX/info --disable-nls --enable-shared --enable-static --with-pf_packet=yes
make
make install
cd ..

cd isic-0.07
./configure
make CC=gcc DEFS="-DHAVE_LIBNET=1 -DSTDC_HEADERS=1 -Din_addr_t=u_int32_t -DVERSION=0.07 -D_BSD_SOURCE -D__BSD_SOURCE -D__FAVOR_BSD -DHAVE_NET_ETHERNET_H -I$PREFIX/include" CFLAGS="-g -O2 " LIBS=$PREFIX/lib/libnet.a 
make PREFIX=$PREFIX install
cd ..


