.PHONY: today notoday build clean atom assets css

.DEFAULT_GOAL := build
SHELL := /bin/bash

TARGET_DIR := build
DRAFT_DIR := draft
MAGIC_TITLE := 0x8964
TEX := typst c --root . --features html 2>/dev/null

title := no-title
today := $(shell date -Idate)
list := $(shell ls src/*/index.typ | sort -r)
targets := $(patsubst src/%/index.typ,$(TARGET_DIR)/%/index.html,$(list))

today: $(DRAFT_DIR)/$(today)-$(title)/index.typ $(DRAFT_DIR)/$(today)-$(title)/meta.typ

$(DRAFT_DIR)/$(today)-$(title)/index.typ:
	@install -D -m 644 tmpl/index.typ $@

$(DRAFT_DIR)/$(today)-$(title)/meta.typ:
	@install -D -m 644 tmpl/meta.typ $@
	@sed -i "s/$(MAGIC_TITLE)/$(title)/g" $@

src/nav.typ: bin/nav.sh $(list)
	@echo "  NAV   $@"
	@mkdir -p $(TARGET_DIR)
	@bin/nav.sh $(patsubst src/%/index.typ,%,$(list)) > $@

src/nav-side.typ: bin/nav.sh $(list)
	@echo "  NAV   $@"
	@mkdir -p $(TARGET_DIR)
	@bin/nav.sh $(patsubst src/%/index.typ,%,$(list)) | sed 's|"\./|"\.\./|g' > $@

notoday:
	@$(RM) -r src/$(today)-*

build: src/nav.typ $(TARGET_DIR)/index.html $(targets) assets

assets: css $(TARGET_DIR)/favicon.webp
css: $(TARGET_DIR)/page.css $(TARGET_DIR)/common.css $(TARGET_DIR)/index.css

$(TARGET_DIR)/%: assets/%
	@echo "  INST  $<"
	@install -D -m 644 $< $@

$(TARGET_DIR)/index.html: index.typ src/nav-side.typ header.typ footer.typ
	@mkdir -p $(@D)
	@echo "  TEX   $<"
	@$(TEX) $< $@

$(TARGET_DIR)/%/index.html: src/%/index.typ src/nav.typ src/%/ page.typ header.typ footer.typ
	@mkdir -p $(@D)
	@cp -r $(<D) $(TARGET_DIR)
	@echo "  TEX   $<"
	@$(TEX) $< $@
	@$(RM) $(@D)/*.typ

clean:
	@echo "  RM    $(TARGET_DIR)/*"
	@$(RM) -r $(TARGET_DIR)/*
	@echo "  RM    src/nav.typ"
	@$(RM) src/nav.typ
	@echo "  RM    src/nav-side.typ"
	@$(RM) src/nav-side.typ

atom: build $(TARGET_DIR)/atom.xml

$(TARGET_DIR)/atom.xml: bin/atom.sh $(targets)
	@echo "  FEED  $@"
	@./bin/atom.sh $(TARGET_DIR) > $@

.DELETE_ON_ERROR:
