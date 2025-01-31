#!/bin/bash

# Configure Homebrew External Commands
echo "Configuring Homebrew..."
brew bundle install --file homebrew/Brewfile && \
brew update && \
brew upgrade && \
brew bundle --force cleanup --file homebrew/Brewfile
brew services cleanup
