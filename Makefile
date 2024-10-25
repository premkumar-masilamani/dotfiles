.PHONY: setup
setup:
	./scripts/setup.sh

.PHONY: dump
dump:
	./scripts/dump.sh

.PHONY: brew
brew:
	./scripts/brew.sh

.PHONY: refresh
refresh:
	./scripts/dump.sh
	./scripts/brew.sh
	git diff homebrew/Brewfile