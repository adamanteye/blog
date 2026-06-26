ifeq ($(V),y)
	TYPST_SILENT :=
else
	TYPST_SILENT := 2>/dev/null
endif

TYPST := typst c --root . --features html

build/%/index.pdf: build/%/index.typ page.typ meta.typ
	$(call log,TYP,$@)
	$(Q)$(TYPST) $< $@ $(TYPST_SILENT)

build/%/main.pdf: build/%/main.typ slide.typ page.typ meta.typ
	$(call log,TYP,$@)
	$(Q)$(TYPST) $< $@ $(TYPST_SILENT)

build/%/index.html: build/%/index.typ page.typ meta.typ $(LIVE_ASSET)
	$(call log,TYP,$<)
	$(Q)$(TYPST) --input src=src/$*/index.typ $< $@ $(TYPST_SILENT)
ifeq ($(LIVE), y)
	$(call log,LIVE,$@)
	$(Q)sed -i 's#</head>#<script src="../../../live.js"></script></head>#' $@
endif
ifeq ($(MINIFY), y)
	$(call log,MINI,$@)
	$(Q)$(MINIFY_CMD) -a -i $@
endif
