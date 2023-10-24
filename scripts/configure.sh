#!/bin/bash

# Configure Z Shell
echo "Configuring Z Shell..."
ln -sf /Users/smileprem/Code/personal/dotfiles/zsh/zshrc.profile ~/.zshrc

# Configure Dracula Theme for Terminal
echo "Configure Dracula Theme for Terminal..."
ln -sf /usr/local/Caskroom/dracula-terminal/1.2.6/terminal-app-master/Dracula.terminal ~/Dracula.terminal
echo "Please follow the instructions to set the theme https://draculatheme.com/terminal"
echo "Also, increase the font size to 16 for legible reading"

# Configure Homebrew
echo "Configuring Homebrew..."
brew bundle install --file homebrew/Brewfile && \
brew update && \
brew upgrade && \
brew bundle --force cleanup --file homebrew/Brewfile

