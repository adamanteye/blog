ifeq ($(V),y)
	TYPST_SILENT :=
else
	TYPST_SILENT := 2>/dev/null
endif

TYPST := typst c --root . --features html

build/%/index.pdf: build/%/index.typ page.typ meta.typ
	$(call log,TEX,$@)
	$(Q)$(TYPST) $< $@ $(TYPST_SILENT)

build/%/index.html: build/%/index.typ $(NAV_SRC) page.typ meta.typ
	$(call log,TEX,$<)
	$(Q)$(TYPST) $< $@ $(TYPST_SILENT)
ifeq ($(LIVE), y)
	$(call log,LIVE,$@)
	$(Q)sed -i '8 i\<script src="../../../live.js"></script>\' $@
endif
ifeq ($(MINIFY), y)
	$(call log,MINI,$@)
	$(Q)$(MINIFY_CMD) -a -i $@
endif
