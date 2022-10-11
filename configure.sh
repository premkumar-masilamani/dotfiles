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

# Configure Homebrew
echo "Configuring Homebrew..."
cd /Users/smileprem/Code/personal/dotfiles/homebrew && \
brew bundle install && \
brew bundle --force cleanup && \
rm -rf Brewfile && \
brew bundle dump
