#!/bin/bash

# Dump Homebrew formulae and casks
rm -rf homebrew/Brewfile || true && \
rm -rf homebrew/Brewfile.lock.json || true && \
brew bundle dump --file homebrew/Brewfile