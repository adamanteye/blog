.PHONY: today notoday build clean atom

.DEFAULT_GOAL := atom
SHELL := /bin/bash

title := no-title
today := $(shell date -Idate)
list := $(shell ls src/*/index.typ | sort -r)
targets := $(patsubst src/%/index.typ,build/%/index.html,$(list))

TARGET_DIR := build
DRAFT_DIR := draft
MAGIC_TITLE := 0x8964
TEX := typst c --root . --features html 2>/dev/null

today: $(DRAFT_DIR)/$(today)-$(title)/index.typ $(DRAFT_DIR)/$(today)-$(title)/meta.typ

$(DRAFT_DIR)/$(today)-$(title)/index.typ:
	@install -D -m 644 tmpl/index.typ $@

$(DRAFT_DIR)/$(today)-$(title)/meta.typ:
	@install -D -m 644 tmpl/meta.typ $@
	@sed -i "s/$(MAGIC_TITLE)/$(title)/g" $@

src/nav.typ: bin/nav.sh $(list)
	@echo "generating navigation $@"
	@mkdir -p $(TARGET_DIR)
	@bin/nav.sh $(patsubst src/%/index.typ,%,$(list)) > $@

notoday:
	@$(RM) -r src/$(today)-*

build: src/nav.typ $(TARGET_DIR)/index.html $(targets) $(TARGET_DIR)/page.css $(TARGET_DIR)/common.css $(TARGET_DIR)/index.css

$(TARGET_DIR)/%.css: %.css
	@echo "installing stylesheet -> $@"
	@install -D -m 644 $< $@

$(TARGET_DIR)/index.html: index.typ src/nav.typ header.typ footer.typ
	@mkdir -p $(@D)
	@echo "compiling $< -> $@"
	@$(TEX) $< $@

$(TARGET_DIR)/%/index.html: src/%/index.typ src/nav.typ src/%/ page.typ header.typ footer.typ
	@mkdir -p $(@D)
	@cp -r $(<D) $(TARGET_DIR)
	@echo "compiling $< -> $@"
	@$(TEX) $< $@
	@$(RM) $(@D)/*.typ

clean:
	@$(RM) -r build/*

atom: build $(TARGET_DIR)/atom.xml

$(TARGET_DIR)/atom.xml: $(targets) bin/atom.sh
	@echo "generating atom feed -> $@"
	@./bin/atom.sh $(TARGET_DIR) > $@

.DELETE_ON_ERROR:
