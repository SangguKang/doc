#
# m-plane 지원 libraries/programs
#
# OS에 포함되지는 않지만, petalinux SDK를 기반으로 build되어야 하기 때문에
# 여기에서 build하여 application에 포함시킴.
#

# Colors
G=\033[0;32m
N=\033[0m

TOOLCHAIN := $(LIB_DIR)/ToolChain.cmake
PKG_CONFIG_PATH := $(PKG_CONFIG_PATH):$(LIB_DIR)/usr/local/lib/pkgconfig
export LIB_DIR SYSROOT TOOLCHAIN PKG_CONFIG_PATH

SUBDIRS = libssh libpcre2 libyang sysrepo libnetconf2 lib_pubkey
CLEANDIRS = libyang sysrepo libssh libnetconf2 lib_pubkey netopeer2 libpcre2
CLEANSUBDIRS = $(addsuffix .clean, $(CLEANDIRS))
INSTALLSUBDIRS = $(addsuffix .install, $(SUBDIRS))

.PHONY: first_rule
first_rule:
        @echo
        @echo "Run the ./build.sh with proper command line option"
        @echo
        @exit 1

.PHONY: toolchain
toolchain:
        ./make_toolchain.sh

.PHONY: all
all: toolchain $(SUBDIRS)

.PHONY: libssh libpcre2 libyang libnetconf2
libssh libpcre2 libyang libnetconf2:
        @echo "TOOLCHAIN :"$(TOOLCHAIN)
        @echo "DESTDIR   :"$(LIB_DIR)
        @d="$@/build"; \
        [ -d "$$d" ] || mkdir "$$d"; \
        cd "$$d"; \
        cmake -DCMAKE_TOOLCHAIN_FILE=$(TOOLCHAIN) ..; \
        make DESTDIR=$(LIB_DIR) install

.PHONY: sysrepo
sysrepo:
        @d="$@/build"; \
        [ -d "$$d" ] || mkdir "$$d"; \
        cd "$$d"; \
        cmake -DCMAKE_TOOLCHAIN_FILE=$(TOOLCHAIN) \
            -DREPO_PATH=/opt/sysrepo/my_repository \
            -DPLUGINS_PATH=/opt/sysrepo-plugin \
            ..; \
        make DESTDIR=$(LIB_DIR) install

.PHONY: lib_pubkey
lib_pubkey:
        @$(MAKE) -C $@ install

.PHONY: install
install: toolchain $(SUBDIRS)

.PHONY: clean
clean: $(CLEANSUBDIRS)

.PHONY: $(CLEANSUBDIRS)
$(CLEANSUBDIRS):
        @d=$(basename $@); \
        echo -e "Clean: ${G} $$d ${N}"; \
        rm -rf "$$d/build"; \
        [ ! -r "$$d/Makefile" ] || $(MAKE) -C "$$d" clean

.PHONY: update
update:
        @./git-update.sh

.PHONY: .FORCE





















