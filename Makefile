SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.ONESHELL:
.DEFAULT_GOAL := help

MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

PREFIX ?= $(HOME)/.config/githooks

SRC := src

GITHOOKS += applypatch-msg post-update pre-commit prepare-commit-msg pre-push pre-rebase
GITHOOKS += commit-msg fsmonitor-watchman pre-applypatch pre-receive update

GITHOOK_FILES := $(addprefix $(PREFIX)/, $(GITHOOKS))
GITHOOK_FOLDERS := $(addsuffix .d,$(GITHOOK_FILES))

help:  ## Help
	grep -E -H '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		sed -n 's/^.*:\(.*\): \(.*\)##\(.*\)/\1%%%\3/p' | \
		column -t -s '%%%'

preinstall:
	install -d $(PREFIX)

$(PREFIX)/env: $(SRC)/env
	cp $(^) $(@)

$(GITHOOK_FILES): $(SRC)/hook
	cp $(^) $(@)

$(GITHOOK_FOLDERS):
	install -d $(@)

update_git: ## Update git with our githooks path
	git config --global core.hooksPath "$(PREFIX)"
.PHONY: update_git

install: preinstall $(PREFIX)/env $(GITHOOK_FILES) $(GITHOOK_FOLDERS) update_git ## install into PREFIX
	
