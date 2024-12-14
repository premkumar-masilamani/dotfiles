#!/bin/bash

USERNAME=premkumar

# Configure Z Shell
echo "Configuring Z Shell..."
ln -sf /Users/$USERNAME/Code/dotfiles/zsh/zshrc.profile ~/.zshrc

# Check if Homebrew is installed
if ! command -v brew &> /dev/null
then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Git global config
echo "Configuring git..."
git config --global user.name "Premkumar Masilamani"
git config --global user.email "premkumar.masilamani.2020@gmail.com"

# Download personal github repos
echo "Downloading personal github repos..."
REPO_LIST=/Users/$USERNAME/Code/dotfiles/github/repos.txt
TARGET_DIR=/Users/$USERNAME/Code
mkdir -p "$TARGET_DIR"
while IFS= read -r REPO_URL; do
  REPO_NAME=$(echo "$REPO_URL" | awk -F'/' '{print $2}')
  if [ ! -d "$TARGET_DIR/$REPO_NAME" ]; then
    echo "Cloning $REPO_URL into $TARGET_DIR"
    git clone "$REPO_URL" "$TARGET_DIR/$REPO_NAME"
  else
    echo "Repository $REPO_NAME already exists in $TARGET_DIR, skipping..."
  fi
done < "$REPO_LIST"
