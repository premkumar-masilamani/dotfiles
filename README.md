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

Run the commands below in order in the Terminal. They are safe to copy‑paste
as‑is. Steps 2 and 3 each have one manual GitHub website action, called out
inline. If you'd rather skip most of this, see
[Minimizing the setup](#minimizing-the-setup) below.

### 1. Install the Command Line Developer Tools

This provides `git` and the compilers Homebrew needs.

```bash
xcode-select --install
```

A pop‑up appears — click **Install** and wait for it to finish before
continuing.

### 2. Create an SSH key and add it to GitHub

Generate a key, load it into the agent/Keychain, and copy the public half to
the clipboard:

```bash
# Generate an ed25519 key (no passphrase, for a fully copy‑paste setup).
# To add a passphrase instead, drop the `-N ""` and type one when prompted.
ssh-keygen -t ed25519 -C "premkumar.masilamani.2020@gmail.com" -f ~/.ssh/id_ed25519 -N ""

# Make macOS load the key from the Keychain automatically on every login.
mkdir -p ~/.ssh
cat >> ~/.ssh/config <<'EOF'
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOF

# Add the key to the agent and copy the public key to the clipboard.
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
```

**Manual step:** open <https://github.com/settings/ssh/new>, paste
(<kbd>⌘V</kbd>) into the *Key* field, give it a title (e.g. the laptop's name),
and click **Add SSH key**.

Verify it works:

```bash
ssh -T git@github.com   # expect: "Hi premkumar-masilamani! You've successfully authenticated..."
```

### 3. Clone the dotfiles repo

```bash
mkdir -p ~/Code
git clone git@github.com:premkumar-masilamani/dotfiles.git ~/Code/dotfiles
cd ~/Code/dotfiles
```

### 4. Run the setup

This installs Homebrew (including the GitHub CLI), links the zsh/Zed configs,
and installs the right package set for this Mac's architecture.

```bash
make setup
```

Open a new Terminal window (or run `source ~/.zshrc`) to pick up the new shell.

### 5. Sign in to the GitHub CLI, then re‑run setup

`make setup` also clones your other repos and applies branch protection, which
needs GitHub authentication. Sign in **once** with the GitHub CLI (it stores
the token in the macOS Keychain — no personal access token to create or
manage), then run setup again to pick up those steps:

```bash
gh auth login   # choose GitHub.com → SSH → your existing key; authenticate in the browser
make setup      # now clones your repos and applies branch protection
```

That's it — `gh` stays signed in from now on, so you never repeat this step on
this Mac. Everyday maintenance (`make refresh`) doesn't touch GitHub at all and
needs no authentication.

### Minimizing the setup

A couple of ways to collapse the steps above:

1. **Let the GitHub CLI handle SSH too.** In step 5, `gh auth login` can
   generate and upload an SSH key for you — so if you clone this repo over
   HTTPS in step 3
   (`git clone https://github.com/premkumar-masilamani/dotfiles.git ~/Code/dotfiles`),
   you can skip the manual `ssh-keygen` in step 2 entirely.

2. **A one‑shot bootstrap.** A small `bootstrap.sh` (invokable as
   `make bootstrap`) could install the Command Line Tools, install Homebrew,
   install and authenticate `gh`, clone this repo, and run `make setup` — so a
   fresh Mac goes from zero to configured with a single pasted command. I can
   add this on request.

## Secrets

- Keep secrets in `~/zshrc.secrets` in your home directory (loaded by `zsh/zshrc.profile`).
- All variables defined there are imported and exported automatically (e.g. project API keys).
- The file is outside this repo and untracked, so it is never committed. Run `chmod 600 ~/zshrc.secrets` to keep it private.
- Do not store API keys or access tokens directly in tracked files.
- GitHub access does **not** belong here — the GitHub CLI (`gh auth login`) manages its own token in the Keychain, so no `GH_TOKEN` is needed.

## Validation

- Run `make check` to execute shell syntax checks and optional shellcheck.
