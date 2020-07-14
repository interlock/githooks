SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c  
.ONESHELL:
.DEFAULT_GOAL := help

MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

SRC := src
DIST := dist

GITHOOKS += applypatch-msg post-update pre-commit prepare-commit-msg pre-push pre-rebase
GITHOOKS += commit-msg fsmonitor-watchman pre-applypatch pre-receive update

GITHOOK_FILES := $(addprefix $(DIST)/, $(GITHOOKS))
GITHOOK_FOLDERS := $(addsuffix .d,$(GITHOOK_FILES))

help:  ## Help
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		sed -n 's/^.*:\(.*\): \(.*\)##\(.*\)/\1%%%\3/p' | \
		column -t -s '%%%'

all: generate

generate: $(DIST) $(DIST)/env $(GITHOOK_FILES) $(GITHOOK_FOLDERS)

dist:
	install -d $(DIST)

$(DIST)/env: $(SRC)/env
	cp $(^) $(@)

$(GITHOOK_FILES): $(SRC)/hook
	cp $(^) $(@)

$(GITHOOK_FOLDERS):
	install -d $(@)