ASSET_CSS := $(notdir $(wildcard assets/*.css))

build/%: assets/%
	$(call log,ASSET,$@)
	$(Q)$(INSTALL) $< $@
