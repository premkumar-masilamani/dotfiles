# Script paths
MANAGE_SCRIPT := ./scripts/manage.sh
ZSH_PROFILE := ./zsh/zshrc.profile

all: refresh

.PHONY: setup
setup: $(MANAGE_SCRIPT)
	@$(MANAGE_SCRIPT) setup

.PHONY: refresh
refresh: $(MANAGE_SCRIPT)
	@$(MANAGE_SCRIPT) refresh
	@git --no-pager diff homebrew/

.PHONY: check
check: $(MANAGE_SCRIPT) $(ZSH_PROFILE)
	@bash -n $(MANAGE_SCRIPT)
	@zsh -n $(ZSH_PROFILE)
	@if command -v shellcheck >/dev/null 2>&1; then \
		shellcheck $(MANAGE_SCRIPT); \
	else \
		echo "shellcheck not installed; skipping"; \
	fi
