#!/bin/bash

# Configure Z Shell
echo "Configuring Z Shell..."
ln -sf /Users/prem/Code/personal/dotfiles/zsh/zshrc.profile ~/.zshrc

# Configure Dracula Theme for Terminal
echo "Configure Dracula Theme for Terminal..."
echo "1. Install Dracula Theme. Refer https://draculatheme.com/terminal"
echo "2. Set Dracula Theme as the default theme"
echo "3. Increase the font size to 14"

# Check if Homebrew is installed
if ! command -v brew &> /dev/null
then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Download personal github repos
echo "Downloading personal github repos..."
REPO_LIST=/Users/prem/Code/personal/dotfiles/github/repos.txt
TARGET_DIR=/Users/prem/Code/personal
mkdir -p "$TARGET_DIR"
# Read each line from the repo list
while IFS= read -r REPO_URL; do
  # Extract the repo name from the URL (assuming URL ends with .git)
  REPO_NAME=$(echo "$REPO_URL" | awk -F'/' '{print $2}')
  
  # Check if the repo already exists in the target directory
  if [ ! -d "$TARGET_DIR/$REPO_NAME" ]; then
    echo "Cloning $REPO_URL into $TARGET_DIR"
    git clone "$REPO_URL" "$TARGET_DIR/$REPO_NAME"
  else
    echo "Repository $REPO_NAME already exists in $TARGET_DIR, skipping..."
  fi
done < "$REPO_LIST"

