LILY_OBJS := $(patsubst %.ly,%.ly.svg,$(shell find src/ -name '*.ly'))

ifeq ($(V),1)
	LILY := lilypond
	LILY_S :=
else
	LILY := lilypond -s
	LILY_S := 2>/dev/null
endif

%.ly.svg: %.ly
	$(call log,LILY,$@)
	$(Q)$(LILY) -o $< --svg $< $(LILY_S)
ifeq ($(MINIFY), y)
	$(call log,MINI,$@)
	$(Q)$(MINIFY_CMD) -a -i $@
endif
