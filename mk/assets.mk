ASSET_CSS := $(notdir $(wildcard assets/*.css))

ASSET_FONT_SUBSETS := \
	fonts/iosevka-latin-400-italic.woff2 \
	fonts/iosevka-latin-400-normal.woff2 \
	fonts/iosevka-latin-600-normal.woff2 \
	fonts/iosevka-latin-700-normal.woff2 \
	fonts/libertinus-serif-latin-400-italic.woff2 \
	fonts/libertinus-serif-latin-400-normal.woff2 \
	fonts/libertinus-serif-latin-600-italic.woff2 \
	fonts/libertinus-serif-latin-600-normal.woff2 \
	fonts/libertinus-serif-latin-700-italic.woff2 \
	fonts/libertinus-serif-latin-700-normal.woff2 \
	fonts/ar-pl-ukai-tw-mbe.woff2
ASSET_FONT_RAW     := \
	fonts/texgyrepagella-math.woff2 \
	fonts/libertinus-serif-OFL.txt \
	fonts/ARPHICPL.TXT
ASSET_FONTS        := $(ASSET_FONT_SUBSETS) $(ASSET_FONT_RAW)
ASSET_FONT_SOURCES := \
	$(filter-out fonts/ar-pl-ukai-tw-mbe.woff2,$(ASSET_FONTS)) \
	fonts/ukai.ttc

BUILD_FONT_SUBSETS := $(addprefix build/,$(ASSET_FONT_SUBSETS))
BUILD_FONT_RAW     := $(addprefix build/,$(ASSET_FONT_RAW))

FONT_CHARS := build/font-chars.txt
FONT_HTML  := build/index.html $(TARGET_POSTS)

CURL       ?= curl
PYTHON     ?= python3
PYFTSUBSET ?= pyftsubset

IOSEVKA_TARBALL             := https://registry.npmjs.org/@fontsource/iosevka/-/iosevka-5.2.5.tgz
LIBERTINUS_TARBALL          := https://registry.npmjs.org/@fontsource/libertinus-serif/-/libertinus-serif-5.3.0.tgz
UKAI_TARBALL                := https://deb.debian.org/debian/pool/main/f/fonts-arphic-ukai/fonts-arphic-ukai_0.2.20080216.2.orig.tar.bz2
UKAI_ARCHIVE_DIR            := fonts-arphic-ukai-0.2.20080216.2
TEX_GYRE_PAGELLA_MATH_WOFF2 := https://mathfonts.github.io/TeXGyrePagella/texgyrepagella-math.woff2

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

build/fonts/ar-pl-ukai-tw-mbe.woff2: assets/fonts/ukai.ttc $(FONT_CHARS)
	$(call log,SUB,$@)
	$(Q)$(MKDIR_P) $(@D)
	$(Q)rm -f "$@.tmp"
	$(Q)$(PYFTSUBSET) $< --font-number=3 --text-file=$(FONT_CHARS) --flavor=woff2 --layout-features='*' --name-IDs='*' --output-file="$@.tmp" 2>/dev/null
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
assets/fonts/libertinus-serif-latin-400-italic.woff2: FONT_TARBALL := $(LIBERTINUS_TARBALL)
assets/fonts/libertinus-serif-latin-400-italic.woff2: FONT_MEMBER := package/files/libertinus-serif-latin-400-italic.woff2
assets/fonts/libertinus-serif-latin-400-normal.woff2: FONT_TARBALL := $(LIBERTINUS_TARBALL)
assets/fonts/libertinus-serif-latin-400-normal.woff2: FONT_MEMBER := package/files/libertinus-serif-latin-400-normal.woff2
assets/fonts/libertinus-serif-latin-600-italic.woff2: FONT_TARBALL := $(LIBERTINUS_TARBALL)
assets/fonts/libertinus-serif-latin-600-italic.woff2: FONT_MEMBER := package/files/libertinus-serif-latin-600-italic.woff2
assets/fonts/libertinus-serif-latin-600-normal.woff2: FONT_TARBALL := $(LIBERTINUS_TARBALL)
assets/fonts/libertinus-serif-latin-600-normal.woff2: FONT_MEMBER := package/files/libertinus-serif-latin-600-normal.woff2
assets/fonts/libertinus-serif-latin-700-italic.woff2: FONT_TARBALL := $(LIBERTINUS_TARBALL)
assets/fonts/libertinus-serif-latin-700-italic.woff2: FONT_MEMBER := package/files/libertinus-serif-latin-700-italic.woff2
assets/fonts/libertinus-serif-latin-700-normal.woff2: FONT_TARBALL := $(LIBERTINUS_TARBALL)
assets/fonts/libertinus-serif-latin-700-normal.woff2: FONT_MEMBER := package/files/libertinus-serif-latin-700-normal.woff2

assets/fonts/ukai.tar.bz2:
	$(call log,FONT,$@)
	$(Q)$(MKDIR_P) $(@D)
	$(Q)rm -f "$@.tmp"
	$(Q)$(CURL) -fsSL "$(UKAI_TARBALL)" > "$@.tmp" && mv "$@.tmp" "$@"

assets/fonts/ukai.ttc: assets/fonts/ukai.tar.bz2
	$(call log,FONT,$@)
	$(Q)rm -f "$@.tmp"
	$(Q)tar -xjOf $< $(UKAI_ARCHIVE_DIR)/ukai.ttc > "$@.tmp" && mv "$@.tmp" "$@"

assets/fonts/ARPHICPL.TXT: assets/fonts/ukai.tar.bz2
	$(call log,FONT,$@)
	$(Q)rm -f "$@.tmp"
	$(Q)tar -xjOf $< $(UKAI_ARCHIVE_DIR)/license/english/ARPHICPL.TXT > "$@.tmp" && mv "$@.tmp" "$@"

assets/fonts/libertinus-serif-OFL.txt:
	$(call log,FONT,$@)
	$(Q)$(MKDIR_P) $(@D)
	$(Q)rm -f "$@.tmp"
	$(Q)set -o pipefail; $(CURL) -fsSL "$(LIBERTINUS_TARBALL)" | tar -xzO package/LICENSE > "$@.tmp" && mv "$@.tmp" "$@"

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
