#!/bin/bash

# Configure Homebrew
echo "Configuring Homebrew..."
brew bundle install --file homebrew/Brewfile && \
brew update && \
brew upgrade && \
brew bundle --force cleanup --file homebrew/Brewfile

