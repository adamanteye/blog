ifeq ($(V),y)
	Q :=
else
	Q := @
endif

define log
	@printf '%-6s %s\n' "$(1)" "$(2)"
endef
