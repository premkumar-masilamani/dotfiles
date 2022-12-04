#!/bin/bash

# Configure Z Shell
echo "Configuring Z Shell..."
ln -sf /Users/smileprem/Code/personal/dotfiles/zsh/zshrc.profile ~/.zshrc

# Configure Alacritty
echo "Configuring Alacritty..."
ln -sf /Users/smileprem/Code/personal/dotfiles/alacritty/alacritty.yml ~/.alacritty.yml

# Configure Prododot
echo "Configuring Prododot..."
ln -sf /Users/smileprem/Code/personal/dotfiles/protodot/config.json ~/config.json

# Upgrade apps from Mac AppStore
echo "Upgrade apps from Mac AppStore..."
mas upgrade

# Configure Homebrew
echo "Configuring Homebrew..."
cd /Users/smileprem/Code/personal/dotfiles/homebrew && \
arch -arm64 brew bundle install && \
arch -arm64 brew bundle --force cleanup

