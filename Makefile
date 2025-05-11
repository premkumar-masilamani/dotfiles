# Makefile for dotfiles management

.PHONY: refresh
refresh:
	./scripts/manage.sh dump
	git diff homebrew/Brewfile

.PHONY: setup
setup:
	./scripts/manage.sh setup

.PHONY: dump
dump:
	./scripts/manage.sh dump

.PHONY: brew
brew:
	./scripts/manage.sh update

.PHONY: all
all:
	./scripts/manage.sh all

.DEFAULT_GOAL := all