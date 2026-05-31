OPTIJPG_OBJS := $(shell find src/ -name '*.jpg' -or -name '*.jpeg')

ifeq ($(V),y)
	OPTIJPG := jpegoptim --strip-all -m 80
else
	OPTIJPG := jpegoptim --strip-all -m 80 -q
endif

%.jpg: DUMMY
	$(call log,OPTIJPG,$@)
	$(Q)$(OPTIJPG) $@

%.jpeg: DUMMY
	$(call log,OPTIJPG,$@)
	$(Q)$(OPTIJPG) $@
