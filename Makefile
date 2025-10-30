.PHONY: today notoday build clean atom

.DEFAULT_GOAL := atom
SHELL := /bin/bash

title := no-title
today := $(shell date --iso-8601=date)
list := $(wildcard src/*)
targets := $(patsubst src/%,build/%/index.html,$(list))

TARGET_DIR := build
MAGIC_TITLE := 0x8964
TEX := typst c --root . --features html 2>/dev/null

today: draft/$(today)-$(title)/index.typ

draft/$(today)-$(title)/index.typ:
	@install -D -m 644 tmpl/index.typ $@
	@sed -i "s/$(MAGIC_TITLE)/$(title)/g" $@

notoday:
	@$(RM) -r src/$(today)-*

build: $(targets)

$(TARGET_DIR)/%/index.html: src/%/index.typ src/%/
	@mkdir -p $(@D)
	@cp -r $(<D) $(TARGET_DIR)
	$(TEX) $< $@
	@$(RM) $(@D)/index.typ

clean:
	@$(RM) -r build/*

atom: build
	@./bin/atom.sh $(TARGET_DIR) > $(TARGET_DIR)/atom.xml

.DELETE_ON_ERROR:
