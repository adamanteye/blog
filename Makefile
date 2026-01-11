MAKEFLAGS += --no-builtin-rules
SHELL := /bin/bash
.DELETE_ON_ERROR:

.PHONY: build clean assets css seo atom today notoday
.DEFAULT_GOAL := build

ifeq ($(V),1)
  Q :=
  TYPST_SILENT :=
  MINIFY_CMD := minify --html-keep-quotes --html-keep-end-tags
else
  Q := @
  TYPST_SILENT := 2>/dev/null
  MINIFY_CMD := minify --html-keep-quotes --html-keep-end-tags -q
endif

define log
	@printf '  %-6s %s\n' "$(1)" "$(2)"
endef

TYPST := typst c --root . --features html
INSTALL := install -D -m 0644
MKDIR_P := mkdir -p
CP_R := cp -r
RM_F := rm -f
RM_RF := rm -rf

TARGET_DIR := build
ASSET_DIR := assets
SRC_DIR := src
DRAFT_DIR := draft
TEMPLATE_INDEX := tmpl/index.typ
TEMPLATE_META := tmpl/meta.typ
NAV_SRC := $(SRC_DIR)/nav.typ
MAGIC_TITLE := 0x8964

MINIFY ?= n

TITLE ?= no-title
TODAY ?= $(shell date -Idate)
TODAY_DIR := $(DRAFT_DIR)/$(TODAY)-$(TITLE)

SRC_PAGES := $(shell ls -d $(SRC_DIR)/*/index.typ | sort -r)
SRC_SECTIONS := $(patsubst $(SRC_DIR)/%/index.typ,%,$(SRC_PAGES))
SRC_META := $(patsubst %,$(SRC_DIR)/%/meta.typ,$(SRC_SECTIONS))
TARGET_POSTS := $(addprefix $(TARGET_DIR)/,$(addsuffix /index.html,$(SRC_SECTIONS)))

ASSET_CSS := $(notdir $(wildcard $(ASSET_DIR)/*.css))

build: assets $(NAV_SRC) $(TARGET_DIR)/index.html $(TARGET_POSTS)

assets: css $(TARGET_DIR)/favicon.webp

css: $(addprefix $(TARGET_DIR)/,$(ASSET_CSS))

today: $(TODAY_DIR)/index.typ $(TODAY_DIR)/meta.typ

atom: build $(TARGET_DIR)/atom.xml

seo: build $(TARGET_DIR)/sitemap.xml $(TARGET_DIR)/robots.txt

notoday:
	$(call log,RM,$(SRC_DIR)/$(TODAY)-*)
	$(Q)$(RM_RF) $(SRC_DIR)/$(TODAY)-*
	$(call log,RM,$(DRAFT_DIR)/$(TODAY)-*)
	$(Q)$(RM_RF) $(DRAFT_DIR)/$(TODAY)-*

$(TODAY_DIR)/index.typ:
	$(call log,NEW,$@)
	$(Q)$(INSTALL) $(TEMPLATE_INDEX) $@

$(TODAY_DIR)/meta.typ:
	$(call log,NEW,$@)
	$(Q)$(INSTALL) $(TEMPLATE_META) $@
	$(Q)sed -i "s/$(MAGIC_TITLE)/$(TITLE)/g" $@

$(NAV_SRC): bin/nav.sh $(SRC_META)
	$(call log,NAV,$@)
	$(Q)$(MKDIR_P) $(TARGET_DIR)
	$(Q)bin/nav.sh $(SRC_SECTIONS) > $@

$(TARGET_DIR)/%: $(ASSET_DIR)/%
	$(call log,ASSET,$@)
	$(Q)$(INSTALL) $< $@

$(TARGET_DIR)/sitemap.xml:
	$(call log,MAP,$@)
	$(Q)bin/sitemap.sh $(@D) > $@
ifeq ($(MINIFY), y)
	$(call log,MINI,$@)
	$(Q)$(MINIFY_CMD) -a -i $@
endif

$(TARGET_DIR)/index.html: index.typ meta.typ
	$(call log,TEX,$<)
	$(Q)$(MKDIR_P) $(@D)
	$(Q)$(TYPST) $< $@ $(TYPST_SILENT)
ifeq ($(MINIFY), y)
	$(call log,MINI,$@)
	$(Q)$(MINIFY_CMD) -a -i $@
endif

$(TARGET_DIR)/%/index.html: $(SRC_DIR)/%/index.typ $(NAV_SRC) page.typ meta.typ
	$(call log,COPY,$(@D))
	$(Q)$(MKDIR_P) $(@D)
	$(Q)$(CP_R) $(<D)/. $(@D)/
	$(call log,TEX,$<)
	$(Q)$(TYPST) $< $@ $(TYPST_SILENT)
ifeq ($(MINIFY), y)
	$(call log,MINI,$@)
	$(Q)$(MINIFY_CMD) -a -i $@
endif
	$(Q)$(RM_F) $(@D)/*.typ

clean:
	$(call log,RM,$(TARGET_DIR))
	$(Q)$(RM_RF) $(TARGET_DIR)
	$(call log,RM,$(NAV_SRC))
	$(Q)$(RM_F) $(NAV_SRC)

$(TARGET_DIR)/atom.xml: bin/atom.sh $(TARGET_POSTS)
	$(call log,FEED,$@)
	$(Q)./bin/atom.sh $(TARGET_DIR) > $@
ifeq ($(MINIFY), y)
	$(call log,MINI,$@)
	$(Q)$(MINIFY_CMD) -a -i $@
endif
