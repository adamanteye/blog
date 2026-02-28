LILY_OBJS := $(patsubst src/%,build/%,$(patsubst %.ly,%.ly.svg,$(shell find src/ -name '*.ly')))

ifeq ($(V),1)
	LILY := lilypond
	LILY_S :=
else
	LILY := lilypond -s
	LILY_S := 2>/dev/null
endif

build/%.ly.svg: src/%.ly
	$(call log,LILY,$@)
	$(Q)$(MKDIR_P) $(@D)
	$(Q)$(CP_R) $< $(@D)
	$(Q)$(LILY) -o $(@D)/$(<F) --svg $(@D)/$(<F) $(LILY_S)
ifeq ($(MINIFY), y)
	$(call log,MINI,$@)
	$(Q)$(MINIFY_CMD) -a -i $@
endif
