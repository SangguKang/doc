#!/bin/bash

# die {{{1
die()
{
    echo "$@"
    exit 1
}

# libpcre2_build {{{1
libpcre2_build()
{
    case "$CMD" in
        clean)
            cd libpcre2; make distclean; cd ..;
            ;;
        *)
            cd libpcre2;
            if [ ! -e config.log ]
            then
                ./autogen.sh;
                ./configure --prefix=$OUT_DIR/usr/local --host=aarch64-xilinx-linux;
            fi
            make && make install
            cd ..
            ;;
    esac
}

# }}}
# openssl_build {{{1
openssl_build()
{
    case "$CMD" in
        clean)
            cd openssl; make distclean; cd ..;
            ;;
        *)
            cd openssl
            if [ "$SSL3" == "ssl3" ];
            then
                /usr/bin/perl ./Configure linux-generic32 shared --prefix=$OUT_DIR --openssldir=$OUT_DIR --cross-compile-prefix=
                make && make install_sw
            fi
            cd ..
            ;;
    esac
}

# }}}
# netopeer2_build {{{1
netopeer2_build()
{
    local builddir="$CUR_DIR/netopeer2/build"
    local TOOLCHAIN="$LIB_DIR/ToolChain.cmake"
    export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:$LIB_DIR/usr/local/lib/pkgconfig"
    case "$CMD" in
        clean)
            rm -rf "$builddir"
            ;;
        *)
            mkdir -p "$builddir"
            pushd "$builddir" >/dev/null
            [ -d ../.git/info ] && echo "/build/" > ../.git/info/exclude
            cmake -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN -DBUILD_CLI=ON \
                -DBUILD_TESTS=OFF -DGENERATE_HOSTKEY=OFF \
                -DINSTALL_MODULES=OFF -DMERGE_LISTEN_CONFIG=OFF \
                ..
            make
            popd >/dev/null
            if [ "$CMD" = "install" ]
            then
                install -d "$LIB_DIR/usr/local/bin"
                install -m 777 "$builddir/netopeer2-server" \
                    "$LIB_DIR/usr/local/bin"
                install -m 777 "$builddir/netopeer2-cli" \
                    "$LIB_DIR/usr/local/bin"
            fi
            ;;
    esac
}

# }}}
# start_build {{{1
start_build()
{
    echo -e ""
    echo -e ""
    echo -e "\t아래 옵션 중 한 가지를 입력하여 진행합니다."
    echo -e "\t(옵션이 없이 Enter 시 install 및 SSLv1.x로 진행)"
    echo -e ""
    echo -e "\tOption: "
    echo -e ""
    echo -e "\t- clean: clean libs."
    echo -e "\t- ssl3: OpenSSL v3.x 적용."
    echo -e ""
    echo -e ""

    echo -e "Option을 입력 하세요:  "
    read inp
    CMD=$inp
}

# }}}

SSL3=""

set -e

. lib-shell.sh

# Get PETALINUX version by various way
# 1. Do not initialize PETALINUX_VER. If already defined, use it.
# 2. Get version from command line option.
# 3. Get version from OECORE_TARGET_SYSROOT env. var.
while getopts p: opt
do
    case "$opt" in
        p) PETALINUX_VER="$OPTARG";;
        *) die "unknown option";;
    esac
done
shift $((OPTIND - 1))
if [ -z "$PETALINUX_VER" ]
then
    if [ -n "$OECORE_TARGET_SYSROOT" ]
    then
        # Extract 2023.1 style version from the env var.
        PETALINUX_VER=$(echo "$OECORE_TARGET_SYSROOT" \
                        | grep -Eo '[0-9]{4}.[0-9]')
    fi
fi
[ -z "$PETALINUX_VER" ] && die "PETALINUX_VER not defined"

# For '*':
#       2019.1/2020.2 = aarch64
#       2023.1        = cortexa72-cortexa53
TOP_DIR=$(cd .. && pwd)
env=$(echo /opt/petalinux/$PETALINUX_VER/environment-setup-*-xilinx-linux)
[ -r "$env" ] || die "cannot find $env"
. "$env"

SYSROOT=$(echo /opt/petalinux/$PETALINUX_VER/sysroots/*-xilinx-linux)
[ -d "$SYSROOT" ] || die "cannot find $SYSROOT"

CUR_DIR="$(pwd)"
OUT_DIR="$CUR_DIR/out"
LIB_DIR="$OUT_DIR"

# start_build에서 인자를 CMD에 전달함.
start_build

[ -d "$OUT_DIR" ] || mkdir "$OUT_DIR"
rm -rf "$OUT_DIR"/*

#CMD="$1"
if [ -z "$CMD" ];
then
    CMD="install"
    sed -i 's/= x_pubkey.c/= pubkey.c/g' lib_pubkey/Makefile
elif [ "$CMD" == "ssl3" ]
then
    SSL3=$CMD
    CMD="install"
    sed -i 's/= pubkey.c/= x_pubkey.c/g' lib_pubkey/Makefile
fi

sudo chown -R $USER:$USER $SYSROOT

openssl_build
# libpcre2_build
make $CMD SYSROOT="$SYSROOT" LIB_DIR="$LIB_DIR"
cp -a "$LIB_DIR/usr/." "$SYSROOT/usr/"
netopeer2_build
[ "$CMD" = "clean" ] && exit 0
[ "$CMD" = "all" ] && exit 0

[ -d "$OUT_DIR/usr/local" ] || die "$OUT_DIR/usr/local not found"

TARFILE="$OUT_DIR/mplane-lib.tar"
rm -f "$TARFILE" "${TARFILE}.gz"

#
# d-oran 프로젝트의 source tree에 맞추어서 tarball을 생성한다.
#       ./include : header files
#       ./aarch64/rootfs/ : rootfs (/usr/local/bin, /usr/local/lib)
#
cd "$OUT_DIR/usr/local"
tar cf "$TARFILE" include/

rm_lib_files="
    ./local/include/
    ./local/share/
    ./local/lib/cmake/
    ./local/lib/pkgconfig/
    ./local/cmake/
    ./local/man/
"

cd "$OUT_DIR/usr/"
mkdir -p "$OUT_DIR"/aarch64/rootfs/usr/
cp -a . "$OUT_DIR"/aarch64/rootfs/usr/
pushd "$OUT_DIR"/aarch64/rootfs/usr/ >/dev/null
rm -rf $rm_lib_files
popd >/dev/null
cd "$OUT_DIR"
tar -r -f "$TARFILE" aarch64/
rm -rf aarch64/

gzip "$TARFILE"

cd "$CUR_DIR"
fname="${TARFILE/${CUR_DIR}\//}.gz"
printf "\n\n"
ls -l "$fname"
printf "\n\n${G}$fname${N} was generated\n\n"

exit 0























