# dotfiles
This repository contains the brew bundle and zsh profile files that manages most of the softwares that I use in my Macbook.

## Architecture-aware setup (Apple Silicon & Intel)

The same repo works on both an Apple Silicon Mac and an older Intel Mac. The
`make` commands auto-detect the architecture (via `uname -m`) and deploy the
matching package set — everything else (zsh profile, prompt, Zed settings,
terminal theme) is shared, so the look and feel stays identical.

| Architecture       | `uname -m` | Homebrew prefix | Brewfile                  |
| ------------------ | ---------- | --------------- | ------------------------- |
| Apple Silicon      | `arm64`    | `/opt/homebrew` | `homebrew/Brewfile.silicon` |
| Intel (older Mac)  | `x86_64`   | `/usr/local`    | `homebrew/Brewfile.intel`   |

- `homebrew/Brewfile.silicon` is the full package set.
- `homebrew/Brewfile.intel` is a drastically reduced subset (shell look & feel
  + core CLI utilities) for the dated Intel laptop.
- `make refresh` / `make dump` re-dump only the Brewfile for the machine you
  run them on, so each Mac keeps its own snapshot in sync.

The `zsh/zshrc.profile` detects the Homebrew prefix at load time and guards the
optional dev-toolchain paths, so the same profile works unchanged on both Macs.

## Instructions to configure a new macbook

- [ ] Open the Terminal, type `git`. There will be a pop-up to install Command Line Developer Tools. Install it.
- [ ] Create and upload SSH Keys to Github. 
- [ ] Create a personal access token from Github and set it as an environment variable `GH_TOKEN`
- [ ] Create a folder `mkdir ~/Code`
- [ ] Clone the dotfiles repo `git clone git@github.com:premkumar-masilamani/dotfiles.git`
- [ ] Run `make setup`

## Secrets

- Keep project secrets in `.zshrc.secrets` at the repository root (loaded by `zsh/zshrc.profile`).
- All variables defined there are imported and exported automatically.
- Do not store API keys or access tokens directly in tracked files.

## Validation

- Run `make check` to execute shell syntax checks and optional shellcheck.
