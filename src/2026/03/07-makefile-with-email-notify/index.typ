#import "/page.typ": *
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

= Motivation

Submitting jobs often needs more than running scripts in `tmux`. Jobs may fail
silently or run for a long time, and the user cannot keep polling their status.

= Makefile

```Makefile
RECEIVER ?= xuelin@adamanteye.cc
PWD := $(shell pwd)
HOST := $(shell uname -n)
SHELL := /bin/bash

define with_mail
	@raw_name='$(if $(strip $(CMD_LABEL)),$(CMD_LABEL),$(CMD))'; \
	jobname="$$(printf '%s' "$$raw_name" \
	| tr '\n' ' ' \
	| sed 's/[[:space:]]\+/ /g; s/^ //; s/ $$//' \
	| sed 's/[^[:alnum:]._-]/-/g; s/-\{2,\}/-/g; s/^-//; s/-$$//' \
	| cut -c1-40)"; \
	started="$$(date +%Y%m%dT%H%M%S%Z)"; \
	[ -n "$$jobname" ] || jobname=null; \
	log="$(PWD)/$$jobname-$$started.log"; \
	set -o pipefail; \
	if { $(CMD); } 2>&1 | tee "$$log"; then \
		printf '%-6s %s\n' "OK" "$(CMD)"; \
	else \
		printf '%-6s %s\n' "Err" "$(CMD)"; \
		{ \
			printf 'Subject: Job %s at %s failed on $(HOST)\n' "$$jobname" "$$started"; \
			printf '\n'; \
			printf 'Command: $(CMD)\n'; \
			printf 'Working dir: $(PWD)\n'; \
			printf 'Log file: %s\n' "$$log"; \
			printf '\n'; \
			printf 'Last 100 lines of log:\n\n'; \
			tail -n 100 "$$log"; \
		} | sendmail "$(RECEIVER)"; \
	fi
endef
```

The idea is to wrap a shell command in a small helper macro. It does three
things:

- gives the job a readable name,
- saves stdout/stderr to a log file,
- emails the user if the job fails.

This is useful for running batch jobs. Compared with running commands directly,
this approach keeps the `make` interface while also preserving a log and a
failure notification path.

= Example Usage

```Makefile
ifeq ($(V),1)
	Q :=
else
	Q := @
endif
include mail.mk
.PHONY: ok err

err: CMD_LABEL = test
err: CMD = echo "hello,world" && exit 42
err:
	$(Q)$(with_mail)

ok: CMD = echo "hello,world"
ok:
	$(Q)$(with_mail)
```

The example output email is:

```
Subject: Job test at 20260307T124008CST failed on adamanteye

Command: echo "hello,world" && exit 42
Working dir: /home/xuelin/test
Log file: /home/xuelin/test/fail-test-20260307T124008CST.log

Last 100 lines of log:

hello,world
```
