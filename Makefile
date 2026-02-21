# Script paths
MANAGE_SCRIPT := ./scripts/manage.sh
ZSH_PROFILE := ./zsh/zshrc.profile
# Generic secret-like variable detector to avoid maintaining per-secret names.
SECRET_VAR_PATTERN := ^[[:space:]]*(export[[:space:]]+)?[A-Za-z_][A-Za-z0-9_]*(key|token|secret|password|pass|private_key|access_key|client_secret)[A-Za-z0-9_]*=

all: refresh

.PHONY: setup
setup: $(MANAGE_SCRIPT)
	@$(MANAGE_SCRIPT) setup

.PHONY: refresh
refresh: $(MANAGE_SCRIPT)
	@$(MANAGE_SCRIPT) refresh
	@git --no-pager diff homebrew/Brewfile

.PHONY: check
check: $(MANAGE_SCRIPT) $(ZSH_PROFILE)
	@bash -n $(MANAGE_SCRIPT)
	@zsh -n $(ZSH_PROFILE)
	@if command -v shellcheck >/dev/null 2>&1; then \
		shellcheck $(MANAGE_SCRIPT); \
	else \
		echo "shellcheck not installed; skipping"; \
	fi
	@if rg -n -i --glob '!zshrc.secrets.example' "$(SECRET_VAR_PATTERN)" ./scripts ./zsh; then \
		echo "Refusing committed secrets. Move secrets to ~/.zshrc.secrets"; \
		exit 1; \
	fi
