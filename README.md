# dotfiles
This repository contains the brew bundle and zsh profile files that manages most of the softwares that I use in my Macbook.

## Architecture-aware setup (Apple Silicon & Intel)

The same repo works on both an Apple Silicon Mac and an older Intel Mac. The
`make` commands auto-detect the architecture (via `uname -m`) and deploy the
matching package set.

| Architecture       | `uname -m` | Homebrew prefix | Brewfile                  |
| ------------------ | ---------- | --------------- | ------------------------- |
| Apple Silicon      | `arm64`    | `/opt/homebrew` | `homebrew/Brewfile.silicon` |
| Intel (older Mac)  | `x86_64`   | `/usr/local`    | `homebrew/Brewfile.intel`   |

- `homebrew/Brewfile.silicon` is the full package set.
- `homebrew/Brewfile.intel` is a drastically reduced subset for the Intel laptop.

## Instructions to configure a new macbook

Run the commands below in order in the Terminal. 

### 1. Install the Command Line Developer Tools

```bash
xcode-select --install
```
A pop‑up appears — click **Install** and wait for it to finish before
continuing.

### 2. Create an SSH key and add it to GitHub


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

```bash
make setup
```

### 5. Initialize CLI tools, then re‑run setup

```bash
gh auth login
gcloud auth init
make setup      # now clones your repos and applies branch protection
```

## Secrets

- Keep secrets in `~/zshrc.secrets` in your home directory (loaded by `zsh/zshrc.profile`).
- Run `chmod 600 ~/zshrc.secrets` to keep it private.
- All variables defined there are imported and exported automatically (e.g. project API keys).
- Run `chmod 600 ~/zshrc.secrets` to keep it private.
- Do not store API keys or access tokens directly in tracked files.

# Maintenance

Run the below command, after installing or uninstalling any software in either of the mac machines

```bash
make refresh
```
