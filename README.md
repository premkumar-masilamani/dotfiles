# dotfiles
This repository contains the brew bundle and zsh profile files that manages most of the softwares that I use in my Macbook.

## Requirements

This repository is designed exclusively for Apple Silicon (`arm64`) Macs.

- **Homebrew Prefix**: `/opt/homebrew`
- **Homebrew Package Set**: Managed via `homebrew/Brewfile`

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
ssh-keygen -t ed25519 -C "premkumar.masilamani.2020@gmail.com" -f ~/.ssh/id_ed25519 -N ""

mkdir -p ~/.ssh
cat >> ~/.ssh/config <<'EOF'
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOF

eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
```

**Manual step:** open <https://github.com/settings/ssh/new>, paste
(<kbd>⌘V</kbd>) into the *Key* field, give it a title (e.g. the laptop's name),
and click **Add SSH key**.

Verify it works:

```bash
ssh -T git@github.com
```

### 3. Clone the dotfiles repo

```bash
mkdir -p ~/Documents/Code
git clone git@github.com:premkumar-masilamani/dotfiles.git ~/Documents/Code/dotfiles
cd ~/Documents/Code/dotfiles
```

### 4. Run the setup

```bash
make setup
```

### 5. Initialize CLI tools, then re‑run setup

```bash
gh auth login
gcloud auth login
make setup
```

## Secrets

- Keep secrets in `~/zshrc.secrets` in your home directory (loaded by `zsh/zshrc.profile`).
- All variables defined there are imported and exported automatically (e.g. project API keys).
- Run `chmod 600 ~/zshrc.secrets` to keep it private.
- Do not store API keys or access tokens directly in tracked files.

# Maintenance

Run the below command after installing or uninstalling any software to keep the `Brewfile` up-to-date:

```bash
make refresh
```
