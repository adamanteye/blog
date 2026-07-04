MAKEFLAGS += --no-builtin-rules
SHELL     := /bin/bash
.DELETE_ON_ERROR:

.PHONY: DUMMY build pdf clean assets css raw-fonts fonts seo atom post slide full optipng jpegoptim
.DEFAULT_GOAL := build

DUMMY:

include mk/log.mk

ifeq ($(V),y)
	MINIFY_CMD := minify --html-keep-quotes --html-keep-end-tags --html-keep-document-tags
else
	MINIFY_CMD := minify --html-keep-quotes --html-keep-end-tags --html-keep-document-tags -q
endif

OBJS :=
include mk/lily.mk
include mk/optipng.mk
include mk/jpegoptim.mk
OBJS    += $(LILY_OBJS)
INSTALL := install -D -m 0644
MKDIR_P := mkdir -p
CP_R    := cp -r
RM_RF   := rm -rf
FIND    := find

TEMPLATE_INDEX := tmpl/index.typ
TEMPLATE_MAIN  := tmpl/main.typ
TEMPLATE_META  := tmpl/meta.typ
MAGIC_TITLE    := 0x8964

MINIFY    ?= n
TITLE     ?= no-title
TODAY     ?= $(shell date +%Y/%m/%d)
TODAY_DIR := src/$(TODAY)-$(TITLE)

SRC_PAGES      := $(shell find src -mindepth 4 -maxdepth 4 -type f -name index.typ | sort -r)
SRC_SLIDES     := $(shell find src -mindepth 4 -maxdepth 4 -type f -name main.typ | sort -r)
SRC_SECTIONS   := $(patsubst src/%/index.typ,%,$(SRC_PAGES))
TARGET_POSTS   := $(addprefix build/,$(addsuffix /index.html,$(SRC_SECTIONS)))
TARGET_PDFS    := $(addprefix build/,$(addsuffix /index.pdf,$(SRC_SECTIONS)))
SRC_SEC_SLIDES := $(patsubst src/%/main.typ,%,$(SRC_SLIDES))
SRC_SECTIONS   += $(SRC_SEC_SLIDES)
TARGET_PDFS    += $(addprefix build/,$(addsuffix /main.pdf,$(SRC_SEC_SLIDES)))
SRC_META       := $(patsubst %,src/%/meta.typ,$(SRC_SECTIONS))
TRASH_COUNT    = $(words $(shell find build \( -name '*.bib' -o -name '*.typ' \) 2>/dev/null))

include mk/assets.mk

LIVE_ASSET :=
ifeq ($(LIVE), y)
LIVE_ASSET := build/live.js
OBJS       += $(LIVE_ASSET)
endif

include mk/typst.mk

build: assets .WAIT build/nav.typ build/index.html $(TARGET_POSTS)
pdf: assets build/nav.typ .WAIT $(TARGET_PDFS)

assets: css raw-fonts build/favicon.webp $(OBJS)

css: $(addprefix build/,$(ASSET_CSS))
raw-fonts: $(addprefix assets/,$(ASSET_FONTS))
fonts: $(addprefix build/,$(ASSET_FONTS))

post: $(TODAY_DIR)/meta.typ $(TODAY_DIR)/index.typ
slide: $(TODAY_DIR)/meta.typ $(TODAY_DIR)/main.typ

atom: build .WAIT build/atom.xml

seo: build .WAIT build/sitemap.xml build/robots.txt

full: atom seo fonts .WAIT pdf .WAIT clean

$(TODAY_DIR)/index.typ:
	$(call log,NEW,$@)
	$(Q)$(INSTALL) $(TEMPLATE_INDEX) $@

$(TODAY_DIR)/main.typ:
	$(call log,NEW,$@)
	$(Q)$(INSTALL) $(TEMPLATE_MAIN) $@

$(TODAY_DIR)/meta.typ:
	$(call log,NEW,$@)
	$(Q)$(INSTALL) $(TEMPLATE_META) $@
	$(Q)sed -i "s/$(MAGIC_TITLE)/$(TITLE)/g" $@

build/nav.typ: bin/nav.sh $(SRC_META)
	$(call log,NAV,$@)
	$(Q)$(MKDIR_P) build
	$(Q)bin/nav.sh src > $@

build/sitemap.xml: build/index.html bin/sitemap.sh
	$(call log,MAP,$@)
	$(Q)bin/sitemap.sh $(@D) > $@
ifeq ($(MINIFY), y)
	$(call log,MINI,$@)
	$(Q)$(MINIFY_CMD) -a -i $@
endif

build/index.html: index.typ meta.typ build/nav.typ $(TARGET_POSTS) $(LIVE_ASSET)
	$(call log,TYP,$<)
	$(Q)$(MKDIR_P) $(@D)
	$(Q)$(TYPST) $< $@ $(TYPST_SILENT)
ifeq ($(LIVE), y)
	$(call log,LIVE,$@)
	$(Q)sed -i 's#</head>#<script src="./live.js"></script></head>#' $@
endif
ifeq ($(MINIFY), y)
	$(call log,MINI,$@)
	$(Q)$(MINIFY_CMD) -a -i $@
endif

build/%/index.typ: src/%/index.typ src/% build/nav.typ
	$(call log,COPY,$(@D))
	$(Q)$(MKDIR_P) $(@D)
	$(Q)$(CP_R) $(<D)/. $(@D)/

build/%/main.typ: src/%/main.typ src/% build/nav.typ
	$(call log,COPY,$(@D))
	$(Q)$(MKDIR_P) $(@D)
	$(Q)$(CP_R) $(<D)/. $(@D)/

clean:
	$(call log,RM,$(TRASH_COUNT) intermediates)
	$(Q)$(FIND) build \( -name '*.bib' -o -name '*.typ' \) -delete
	$(Q)$(RM_RF) build/nav.typ

build/atom.xml: bin/atom.sh build/index.html
	$(call log,FEED,$@)
	$(Q)./bin/atom.sh build > $@
ifeq ($(MINIFY), y)
	$(call log,MINI,$@)
	$(Q)$(MINIFY_CMD) -a -i $@
endif

optipng: $(OPTIPNG_OBJS)
jpegoptim: $(OPTIJPG_OBJS)
