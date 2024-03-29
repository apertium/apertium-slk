###############################################################################
## Makefile for apertium-slk
###############################################################################

LANG1=slk
BASENAME=apertium-$(LANG1)

TARGETS_COMMON = $(LANG1).automorf.bin $(LANG1).autogen.bin \
        $(LANG1).prob \
	$(LANG1).automorf.att.gz $(LANG1).autogen.att.gz

#        $(LANG1).rlx.bin

@ap_include@

###############################################################################
## Slovak transducer
###############################################################################

$(LANG1).autogen.bin: $(BASENAME).$(LANG1).dix
	lt-comp rl $< $@

$(LANG1).automorf.bin: $(BASENAME).$(LANG1).dix
	lt-comp lr $< $@

$(LANG1).autogen.att.gz: $(LANG1).autogen.bin
	lt-print $< | gzip -9 -c -n > $@

$(LANG1).automorf.att.gz: $(LANG1).automorf.bin
	lt-print $< | gzip -9 -c -n > $@

###############################################################################
## Disambiguation rules
###############################################################################

# $(LANG1).rlx.bin: $(BASENAME).$(LANG1).rlx
# 	cg-comp $< $@

###############################################################################
## Distribution
###############################################################################
EXTRA_DIST=$(BASENAME).$(LANG1).dix \
           $(LANG1).prob \
	   modes.xml

#	   $(BASENAME).$(LANG1).rlx

###############################################################################
## Installation stuff
###############################################################################
#
#   apertium_slk_dir: This is where the compiled binaries go
#   apertium_slk_srcdir: This is where the source files go

apertium_slkdir=$(prefix)/share/apertium/$(BASENAME)/
apertium_slk_srcdir=$(prefix)/share/apertium/$(BASENAME)/

apertium_slk_DATA=$(TARGETS_COMMON)

pkgconfigdir = $(prefix)/share/pkgconfig
pkgconfig_DATA = $(BASENAME).pc

# Modes are not installed since they're all just "debug modes". All
# modes are created by this goal.
modes/$(LANG1)-morph.mode: modes.xml
	apertium-validate-modes modes.xml
	apertium-gen-modes modes.xml

noinst_DATA=modes/$(LANG1)-morph.mode

install-data-local: install-modes
	test -d $(DESTDIR)$(apertium_slk_srcdir) || mkdir -p $(DESTDIR)$(apertium_slk_srcdir)
	$(INSTALL_DATA) $(BASENAME).$(LANG1).dix $(DESTDIR)$(apertium_slk_srcdir)
#	$(INSTALL_DATA) $(BASENAME).$(LANG1).rlx $(DESTDIR)$(apertium_slk_srcdir)

CLEANFILES = $(TARGETS_COMMON)
clean-local:
	-rm -rf .deps modes

test: all
	apertium-regtest test
