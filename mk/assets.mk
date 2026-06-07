ASSET_CSS   := $(notdir $(wildcard assets/*.css))
ASSET_FONTS := \
	fonts/iosevka-latin-400-italic.woff2 \
	fonts/iosevka-latin-400-normal.woff2 \
	fonts/iosevka-latin-600-normal.woff2 \
	fonts/iosevka-latin-700-normal.woff2 \
	fonts/lxgw-wenkai-sc-cjk-400-normal.woff2 \
	fonts/lxgw-wenkai-sc-cjk-700-normal.woff2 \
	fonts/lxgw-wenkai-tc-cjk-400-normal.woff2 \
	fonts/lxgw-wenkai-tc-cjk-700-normal.woff2

FONT_CHARS := build/font-chars.txt
FONT_HTML  := build/index.html $(TARGET_POSTS)

CURL       ?= curl
PYTHON     ?= python3
PYFTSUBSET ?= pyftsubset

IOSEVKA_TARBALL := https://registry.npmjs.org/@fontsource/iosevka/-/iosevka-5.2.5.tgz
LXGW_SC_TARBALL := https://registry.npmjs.org/@fontsource/lxgw-wenkai/-/lxgw-wenkai-5.2.5.tgz
LXGW_TC_TARBALL := https://registry.npmjs.org/@fontsource/lxgw-wenkai-tc/-/lxgw-wenkai-tc-5.2.9.tgz

$(FONT_CHARS): bin/font-chars.py $(FONT_HTML)
	$(call log,CHAR,$@)
	$(Q)$(MKDIR_P) $(@D)
	$(Q)./bin/font-chars.py $(filter %.html,$^) > $@

build/fonts/%.woff2: assets/fonts/%.woff2 $(FONT_CHARS)
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
assets/fonts/lxgw-wenkai-sc-cjk-400-normal.woff2: FONT_TARBALL := $(LXGW_SC_TARBALL)
assets/fonts/lxgw-wenkai-sc-cjk-400-normal.woff2: FONT_MEMBER := package/files/lxgw-wenkai-latin-500-normal.woff2
assets/fonts/lxgw-wenkai-sc-cjk-700-normal.woff2: FONT_TARBALL := $(LXGW_SC_TARBALL)
assets/fonts/lxgw-wenkai-sc-cjk-700-normal.woff2: FONT_MEMBER := package/files/lxgw-wenkai-latin-700-normal.woff2
assets/fonts/lxgw-wenkai-tc-cjk-400-normal.woff2: FONT_TARBALL := $(LXGW_TC_TARBALL)
assets/fonts/lxgw-wenkai-tc-cjk-400-normal.woff2: FONT_MEMBER := package/files/lxgw-wenkai-tc-chinese-traditional-400-normal.woff2
assets/fonts/lxgw-wenkai-tc-cjk-700-normal.woff2: FONT_TARBALL := $(LXGW_TC_TARBALL)
assets/fonts/lxgw-wenkai-tc-cjk-700-normal.woff2: FONT_MEMBER := package/files/lxgw-wenkai-tc-chinese-traditional-700-normal.woff2

assets/fonts/%.woff2:
	$(call log,FONT,$@)
	$(Q)$(MKDIR_P) $(@D)
	$(Q)rm -f "$@.tmp"
	$(Q)set -o pipefail; $(CURL) -fsSL "$(FONT_TARBALL)" | tar -xzO "$(FONT_MEMBER)" > "$@.tmp" && mv "$@.tmp" "$@"
