ifeq ($(V),y)
	LILYPOND := lilypond
	LILY_S :=
else
	LILYPOND := lilypond -s
	LILY_S := 2>/dev/null
endif

LILY_SRCS := $(shell find src/ -name '*.ly')
LILY_OBJS := $(patsubst src/%.ly,build/%.ly.svg,$(LILY_SRCS))

.NOTINTERMEDIATE: $(LILY_OBJS)


build/%.ly.svg: src/%.ly
	$(call log,LILY,$@)
	$(Q)$(MKDIR_P) "$(@D)"
	$(Q)$(LILYPOND) -o "$(@:.svg=)" --svg "$<" $(LILY_S)
ifeq ($(MINIFY), y)
	$(call log,MINI,$@)
	$(Q)$(MINIFY_CMD) -a -i $@
endif
