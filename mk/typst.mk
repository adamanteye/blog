ifeq ($(V),1)
	TYPST_SILENT :=
else
	TYPST_SILENT := 2>/dev/null
endif

TYPST := typst c --root . --features html

$(TARGET_DIR)/%/index.pdf: $(TARGET_DIR)/%/index.typ page.typ meta.typ
	$(call log,TEX,$@)
	$(Q)$(TYPST) $< $@ $(TYPST_SILENT)

$(TARGET_DIR)/%/index.html: $(TARGET_DIR)/%/index.typ $(NAV_SRC) page.typ meta.typ
	$(call log,TEX,$<)
	$(Q)$(TYPST) $< $@ $(TYPST_SILENT)
ifeq ($(MINIFY), y)
	$(call log,MINI,$@)
	$(Q)$(MINIFY_CMD) -a -i $@
endif
