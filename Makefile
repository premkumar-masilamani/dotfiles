# Script paths
MANAGE_SCRIPT := ./scripts/manage.sh

all: refresh

.PHONY: setup
setup: $(MANAGE_SCRIPT)
	@$(MANAGE_SCRIPT) setup

.PHONY: refresh
refresh: $(MANAGE_SCRIPT)
	@$(MANAGE_SCRIPT) refresh
	@git --no-pager diff homebrew/Brewfile
