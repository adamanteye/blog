OPTIPNG_OBJS := $(shell find src/ -name '*.png')

ifeq ($(V),y)
	OPTI := optipng -o7
else
	OPTI := optipng -silent -o7
endif

%.png: DUMMY
	$(call log,OPTI,$@)
	$(Q)$(OPTI) $@

DUMMY:

.PHONY: DUMMY
