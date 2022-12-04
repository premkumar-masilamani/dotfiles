# dotfiles
My configurations


# Upgrade Homebrew (manually)
```zshell
arch -arm64 brew upgrade && \
cd /Users/smileprem/Code/personal/dotfiles/homebrew && \
rm -rf Brewfile && \
arch -arm64 brew bundle dump
```
