#!/bin/bash

# Configure Z Shell
ln -sf /Users/smileprem/Code/personal/dotfiles/zsh/zshrc.profile ~/.zshrc

# Configure Alacritty
ln -sf /Users/smileprem/Code/personal/dotfiles/alacritty/alacritty.yml ~/.alacritty.yml

# Configure Prododot
ln -sf /Users/smileprem/Code/personal/dotfiles/protodot/config.json ~/config.json

# Configure Homebrew
#brew bundle dump
#brew bundle --force cleanup
cd /Users/smileprem/Code/personal/dotfiles/homebrew && brew bundle install