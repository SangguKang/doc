# vim:set ts=8 sts=4 sw=4 noet:
#
# Top level Makefile
#

TOP_DIR  := $(shell pwd)
SCRIPT_DIR := $(TOP_DIR)/scripts
MK_DIR := $(TOP_DIR)/mk
NLIB_SCRIPT_DIR := $(TOP_DIR)/nlib/scripts
OUT_DIR := $(TOP_DIR)/out
IN_DIR := $(TOP_DIR)/in
ROOTFS_CMN := $(TOP_DIR)/app/common/rootfs
export TOP_DIR SCRIPT_DIR MK_DIR NLIB_SCRIPT_DIR OUT_DIR

ALL_DIRS := $(shell find . -maxdepth 1 -type d | sed -e 's/\.//' -e 's/\///')

MAIN_MK := $(MK_DIR)/main.mk
MKCONFIG_SH := $(NLIB_SCRIPT_DIR)/mk_config.sh
MKFILE_SH := $(IN_DIR)/make_file.sh

DOT_CONFIG := $(TOP_DIR)/.config
-include $(DOT_CONFIG)

# default install dir
DESTDIR := $(AP_DESTDIR)

ifdef DOT_CONFIG_DEFINED
# Configured {{{1

# default rule
.PHONY: all
all: ap

AP_SUBDIRS :=

AP_SUBDIRS += nlib hal app

ap:: pkg_prep
        @$(MAKE) mk_app DESTDIR=$(AP_DESTDIR)

# pkg_prep {{{1
.PHONY: pkg_prep
pkg_prep: config_chk
        @if ! $(MAKE) -C host all >$(STDOUT) 2>$(STDERR); \
        then exit 1; fi

.PHONY: config_chk
config_chk:
        @for f in $(DOT_CONFIG_IN) $(MKCONFIG_SH); \
        do \
            if [ "$$f" -nt $(DOT_CONFIG) ]; then \
                echo "Config file \"$$f\" was changed.  Please reconfigure."; \
                exit 1; \
            fi; \
        done

# nlib {{{1
.PHONY: nlib nlib/install
nlib:
        @$(call print,compile,$@); \
            if ! $(MAKE) -C nlib \
                CROSS_CFLAGS="$(CROSS_CFLAGS)" \
                CROSS_LDFLAGS="$(CROSS_LDFLAGS)" \
                BOARD=$(BOARD) DOT_CONFIG_NAME=$(DOT_CONFIG_NAME) \
                >$(STDOUT) 2>$(STDERR); \
            then exit 1; fi; \
            if ! $(MAKE) $@/install; then exit 1; fi

nlib/install:
        @$(call print,install,`expr $@ : '\(.*\)/install'`); \
            if ! $(MAKE) -C nlib install-libs DESTDIR=$(DESTDIR) \
                BOARD=$(BOARD) DOT_CONFIG_NAME=$(DOT_CONFIG_NAME) \
                >$(STDOUT) 2>$(STDERR); \
            then exit 1; fi; \
            $(STRIP) "$(DESTDIR)/usr/lib"/libn.so.*.*.*

# hal {{{1
.PHONY: hal hal/install
hal:
        @$(call print,compile,$@); \
            if ! $(MAKE) -C hal >$(STDOUT) 2>$(STDERR); \
            then exit 1; fi; \
            if ! $(MAKE) $@/install; then exit 1; fi

hal/install:
        @$(call print,install,`expr $@ : '\(.*\)/install'`); \
            if ! $(MAKE) -C hal install DESTDIR=$(DESTDIR) \
                >$(STDOUT) 2>$(STDERR); \
            then exit 1; fi; \
            $(STRIP) "$(DESTDIR)/usr/lib"/libhal.so.*.*.*

# dhcpcd {{{1
.PHONY: dhcpcd dhcpcd/install
dhcpcd:
        @$(call print,compile,$@); \
            cd dhcpcd; \
            [ -r config.h -a -r config.mk -a config.h -nt configure ] \
            || ./configure --host=$(CROSS_HOST) --without-udev \
                --build=$(CROSS_BUILD) --disable-ipv6 \
                --disable-ipv4ll --disable-arping \
                --disable-dhcp6 --enable-debug >$(STDOUT) 2>$(STDERR); \
            if ! $(MAKE) >$(STDOUT) 2>$(STDERR); then exit 1; fi; \
            cd $(TOP_DIR); \
            if ! $(MAKE) $@/install; then exit 1; fi

dhcpcd/install:
        @$(call print,install,`expr $@ : '\(.*\)/install'`); \
            d="dhcpcd/src/dhcpcd"; \
            [ -x "$$d" ] && chmod 0755 "$$d" && $(STRIP) "$$d" \
            && chmod 0555 "$$d" && cp -f "$$d" $(ROOTFS_CMN)/sbin/; \
# app {{{1
.PHONY: app app/install
app:
        @$(call print,compile,$@); \
        if [ -n "$(CONFIG_MACH_SIM)" ]; then \
            if ! $(SCRIPT_DIR)/run_sim.sh -c; then exit 1; fi; \
        fi; \
        if ! $(MAKE) -C app all \
            DESTDIR=$(AP_DESTDIR) >$(STDOUT) 2>$(STDERR); then exit 1; fi; \
        if ! $(MAKE) $@/install DESTDIR=$(AP_DESTDIR); then exit 1; fi

app/install:
        @$(call print,install,`expr $@ : '\(.*\)/install'`); \
        if ! $(MAKE) -C app install DESTDIR=$(AP_DESTDIR) \
            >$(STDOUT) 2>$(STDERR); then exit 1; fi

.PHONY: mk_app
mk_app:
        @if [ -n "$(CONFIG_MACH_SIM)" ]; then \
            if ! $(SCRIPT_DIR)/run_sim.sh -c; then exit 1; fi; \
        else \
            rm -rf $(AP_DESTDIR); \
            mkdir -p $(AP_DESTDIR); \
        fi; \
        if ! $(MKFILE_SH) $(CONFIG_PRODUCT_CODE) $(CONFIG_VENDOR_CLASS_ID) \
            $(CONFIG_MAX_FRAME_STRUCTURE) $(CONFIG_MAX_FRAME_STRUCTURE_PRACH) \
            $(CONFIG_MAX_PRB_PER_SYMBOL) $(CONFIG_MAX_PRB_PER_SYMBOL_PRACH) \
            $(CONFIG_SCS_DL) $(CONFIG_SCS_UL) $(CONFIG_SCS_PRACH) \
            $(CONFIG_CENTER_CHANNEL_BW_DL) $(CONFIG_CENTER_CHANNEL_BW_UL) \
            $(CONFIG_CHANNEL_BW); then exit 1; fi; \
        for d in $(AP_SUBDIRS); do \
            if ! $(MAKE) $$d DESTDIR=$(AP_DESTDIR); \
            then exit 1; fi; \
        done; \
        if [ -z "$(CONFIG_MACH_SIM)" ]; then \
            pushd $(AP_DESTDIR) >/dev/null; \
            tar cf $(OUT_DIR)/app.tar .; \
            popd >/dev/null; \
            echo; \
            BOARD=$(BOARD) CPU=$(CPU) DEV_TYPE=$(DEV_TYPE) \
                $(SCRIPT_DIR)/mk_pkg.sh ap "0" $(OUT_DIR)/app.tar \
                $(OUT_DIR); \
            rm -f $(OUT_DIR)/app.tar; \
        fi

# gen_compiledb: {{{1
gen_compiledb:
        $(Q)printf "Generating compile_commands.json ... "; \
        make clean >/dev/null 2>&1; \
        make V=1 | compiledb; \
        echo "DONE"

# }}}
else # DOT_CONFIG_DEFINED
# No Conguration Yet {{{1
all ap $(ALL_DIRS): .FORCE
        @echo "No config yet.  Select one of config in configs/*"; \
        exit 0

# }}}
endif # DOT_CONFIG_DEFINED

# config rule {{{1
define CONFIG_RULES
$(1) $(1)_defconfig configs/$(1)_defconfig: .FORCE
        @cfg=`basename $$@ | sed 's/_defconfig//g'`; \
        printf "Configuring for $(G)configs/$$$${cfg}_defconfig$(N)\n"; \
        [ -d "$(OUT_DIR)" ] || mkdir -p "$(OUT_DIR)"; \
        if ! $(MKCONFIG_SH) -c $(DOT_CONFIG) \
            -h $(OUT_DIR)/autoconf-$$$${cfg}.h \
            $(TOP_DIR)/configs/$$$${cfg}_defconfig \
            $(MAIN_MK); then exit 1; fi
endef

$(foreach f, $(wildcard configs/*_defconfig), \
    $(eval $(call CONFIG_RULES,$(shell basename $(f) | sed 's/_defconfig//'))))

# distclean rule {{{1
distclean: app/distclean
        -@$(MAKE) -C host distclean
        -@rm -rf .config tags TAGS cscope.*

define DISTCLEAN_RULES
$(1)/distclean:: .FORCE
        -@$$(call print,distclean,$(1)); \
        [ ! -r $(1)/Makefile ] || $$(MAKE) -C $(1) distclean
endef

$(foreach d, $(ALL_DIRS), $(eval $(call DISTCLEAN_RULES,$(d))))

# app에 대해서는 $(AP_SUBDIRS) 및 추가 clean
app/distclean:: $(foreach d,$(filter-out app,$(AP_SUBDIRS)),$(d)/distclean)
        -@rm -rf $(AP_DESTDIR)

# clean rule {{{1
clean: app/clean
        -@$(MAKE) -C host clean

define CLEAN_RULES
$(1)/clean:: .FORCE
        -@$$(call print,clean,$(1)); \
        [ ! -r $(1)/Makefile ] || $$(MAKE) -C $(1) clean
endef

$(foreach d, $(ALL_DIRS), $(eval $(call CLEAN_RULES,$(d))))

# app에 대해서는 $(AP_SUBDIRS)도 clean
app/clean:: $(foreach d,$(filter-out app,$(AP_SUBDIRS)),$(d)/clean)

# update rule {{{1
update: .FORCE
        @git pull --recurse-submodules=no \
            && git submodule update --init --checkout

# ctags rule {{{1
CTAGS_FLAGS  = -f tags -B --extra=+f --c-kinds=-px --fields=+l
CTAGS_FLAGS += --langmap=make:+.mk --langmap=c:.c.h
CTAGS_FLAGS += '--langmap=make:(*_defconfig)'
CTAGS_FLAGS += '--exclude=*.js'
CTAGS_FLAGS += -I LOCAL=static
TAGS tags: .FORCE
        -@printf "Generating C tags ..."; \
        ctags $(CTAGS_FLAGS) -R $(AP_SUBDIRS) mk configs; \
        ctags $(CTAGS_FLAGS) -R -a --c-kinds=+p libs; \
        echo " DONE"

# cscope rule {{{1
cscope: .FORCE
        -@printf "Generating cscope .."; \
        rm -f cscope.files; \
        find ./nlib -name '*.[ch]' -print > cscope.files; \
        find ./app -name '*.[ch]' -print >> cscope.files; \
        find . -maxdepth 1 -name '*.h' >> cscope.files; \
        cscope -b -i cscope.files -f cscope.out 2>/dev/null; \
        rm -f cscope.files; \
        echo " DONE"

# }}}

.PHONY: .FORCE
