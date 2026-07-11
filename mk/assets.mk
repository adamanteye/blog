ASSET_CSS := $(notdir $(wildcard assets/*.css))

ASSET_FONT_SUBSETS := \
	fonts/iosevka-latin-400-italic.woff2 \
	fonts/iosevka-latin-400-normal.woff2 \
	fonts/iosevka-latin-600-normal.woff2 \
	fonts/iosevka-latin-700-normal.woff2 \
	fonts/lxgw-wenkai-sc-cjk-400-normal.woff2 \
	fonts/lxgw-wenkai-sc-cjk-500-normal.woff2 \
	fonts/lxgw-wenkai-tc-cjk-400-normal.woff2 \
	fonts/lxgw-wenkai-tc-cjk-700-normal.woff2
ASSET_FONT_RAW     := \
	fonts/texgyrepagella-math.woff2
ASSET_FONTS        := $(ASSET_FONT_SUBSETS) $(ASSET_FONT_RAW)
ASSET_FONT_SC_SRC  := \
	fonts/lxgw-wenkai-sc-cjk-400-normal.ttf \
	fonts/lxgw-wenkai-sc-cjk-500-normal.ttf
ASSET_FONT_SOURCES := \
	$(filter-out fonts/lxgw-wenkai-sc-cjk-%.woff2,$(ASSET_FONTS)) \
	$(ASSET_FONT_SC_SRC)

BUILD_FONT_SUBSETS := $(addprefix build/,$(ASSET_FONT_SUBSETS))
BUILD_FONT_RAW     := $(addprefix build/,$(ASSET_FONT_RAW))

FONT_CHARS := build/font-chars.txt
FONT_HTML  := build/index.html $(TARGET_POSTS)

CURL       ?= curl
PYTHON     ?= python3
PYFTSUBSET ?= pyftsubset

IOSEVKA_TARBALL             := https://registry.npmjs.org/@fontsource/iosevka/-/iosevka-5.2.5.tgz
LXGW_TC_TARBALL             := https://registry.npmjs.org/@fontsource/lxgw-wenkai-tc/-/lxgw-wenkai-tc-5.2.9.tgz
TEX_GYRE_PAGELLA_MATH_WOFF2 := https://mathfonts.github.io/TeXGyrePagella/texgyrepagella-math.woff2
LXGW_SC_REGULAR_TTF         := https://github.com/lxgw/LxgwWenKai/releases/download/v1.522/LXGWWenKai-Regular.ttf
LXGW_SC_MEDIUM_TTF          := https://github.com/lxgw/LxgwWenKai/releases/download/v1.522/LXGWWenKai-Medium.ttf

$(FONT_CHARS): bin/font-chars.py $(FONT_HTML)
	$(call log,CHAR,$@)
	$(Q)$(MKDIR_P) $(@D)
	$(Q)./bin/font-chars.py $(filter %.html,$^) > $@

$(BUILD_FONT_RAW): build/%: assets/%
	$(call log,ASSET,$@)
	$(Q)$(MKDIR_P) $(@D)
	$(Q)$(INSTALL) $< $@

build/fonts/%.woff2: assets/fonts/%.woff2 $(FONT_CHARS)
	$(call log,SUB,$@)
	$(Q)$(MKDIR_P) $(@D)
	$(Q)rm -f "$@.tmp"
	$(Q)$(PYFTSUBSET) $< --text-file=$(FONT_CHARS) --flavor=woff2 --layout-features='*' --output-file="$@.tmp" 2>/dev/null
	$(Q)mv "$@.tmp" "$@"

build/fonts/lxgw-wenkai-sc-cjk-%.woff2: assets/fonts/lxgw-wenkai-sc-cjk-%.ttf $(FONT_CHARS)
	$(call log,SUB,$@)
	$(Q)$(MKDIR_P) $(@D)
	$(Q)rm -f "$@.tmp"
	$(Q)$(PYFTSUBSET) $< --text-file=$(FONT_CHARS) --flavor=woff2 --layout-features='*' --output-file="$@.tmp" 2>/dev/null
	$(Q)mv "$@.tmp" "$@"

build/%: assets/%
	$(call log,ASSET,$@)
	$(Q)$(INSTALL) $< $@

assets/fonts/iosevka-latin-400-italic.woff2: FONT_TARBALL := $(IOSEVKA_TARBALL)
assets/fonts/iosevka-latin-400-italic.woff2: FONT_MEMBER := package/files/iosevka-latin-400-italic.woff2
assets/fonts/iosevka-latin-400-normal.woff2: FONT_TARBALL := $(IOSEVKA_TARBALL)
assets/fonts/iosevka-latin-400-normal.woff2: FONT_MEMBER := package/files/iosevka-latin-400-normal.woff2
assets/fonts/iosevka-latin-600-normal.woff2: FONT_TARBALL := $(IOSEVKA_TARBALL)
assets/fonts/iosevka-latin-600-normal.woff2: FONT_MEMBER := package/files/iosevka-latin-600-normal.woff2
assets/fonts/iosevka-latin-700-normal.woff2: FONT_TARBALL := $(IOSEVKA_TARBALL)
assets/fonts/iosevka-latin-700-normal.woff2: FONT_MEMBER := package/files/iosevka-latin-700-normal.woff2
assets/fonts/lxgw-wenkai-tc-cjk-400-normal.woff2: FONT_TARBALL := $(LXGW_TC_TARBALL)
assets/fonts/lxgw-wenkai-tc-cjk-400-normal.woff2: FONT_MEMBER := package/files/lxgw-wenkai-tc-chinese-traditional-400-normal.woff2
assets/fonts/lxgw-wenkai-tc-cjk-700-normal.woff2: FONT_TARBALL := $(LXGW_TC_TARBALL)
assets/fonts/lxgw-wenkai-tc-cjk-700-normal.woff2: FONT_MEMBER := package/files/lxgw-wenkai-tc-chinese-traditional-700-normal.woff2

assets/fonts/lxgw-wenkai-sc-cjk-400-normal.ttf: FONT_URL := $(LXGW_SC_REGULAR_TTF)
assets/fonts/lxgw-wenkai-sc-cjk-500-normal.ttf: FONT_URL := $(LXGW_SC_MEDIUM_TTF)

assets/fonts/lxgw-wenkai-sc-cjk-%.ttf:
	$(call log,FONT,$@)
	$(Q)$(MKDIR_P) $(@D)
	$(Q)rm -f "$@.tmp"
	$(Q)$(CURL) -fsSL "$(FONT_URL)" > "$@.tmp" && mv "$@.tmp" "$@"

assets/fonts/texgyrepagella-math.woff2:
	$(call log,FONT,$@)
	$(Q)$(MKDIR_P) $(@D)
	$(Q)rm -f "$@.tmp"
	$(Q)$(CURL) -fsSL "$(TEX_GYRE_PAGELLA_MATH_WOFF2)" > "$@.tmp" && mv "$@.tmp" "$@"

assets/fonts/%.woff2:
	$(call log,FONT,$@)
	$(Q)$(MKDIR_P) $(@D)
	$(Q)rm -f "$@.tmp"
	$(Q)set -o pipefail; $(CURL) -fsSL "$(FONT_TARBALL)" | tar -xzO "$(FONT_MEMBER)" > "$@.tmp" && mv "$@.tmp" "$@"
