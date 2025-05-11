#!/bin/bash

set -euo pipefail

# Configuration
readonly USERNAME="premkumar"

readonly CODE_DIR="/Users/${USERNAME}/Code"
readonly DOTFILES_DIR="${CODE_DIR}/dotfiles"

readonly BREW_FILE="${DOTFILES_DIR}/homebrew/Brewfile"
readonly REPO_LIST="${DOTFILES_DIR}/github/repos.txt"

readonly GIT_NAME="Premkumar Masilamani"
readonly GIT_EMAIL="premkumar.masilamani.2020@gmail.com"

verify_directories() {
    local dirs=("$DOTFILES_DIR" "$CODE_DIR")
    for dir in "${dirs[@]}"; do
        if [[ ! -d "$dir" ]]; then
            echo "Creating directory: $dir"
            mkdir -p "$dir"
        fi
    done
}

dump_homebrew() {
    echo "Dumping Homebrew packages..."
    rm -f "${BREW_FILE}" "${BREW_FILE}.lock.json"
    brew bundle dump --file="$BREW_FILE"
    echo "Brewfile updated successfully"
}

update_homebrew() {
    echo "Updating Homebrew packages..."
    if [[ ! -f "$BREW_FILE" ]]; then
        echo "Brewfile not found at $BREW_FILE"
        return 1
    fi

    brew bundle install --file="$BREW_FILE" && \
    brew update && \
    brew upgrade && \
    brew bundle --force cleanup --file="$BREW_FILE" && \
    brew services cleanup

    echo "Homebrew packages updated successfully"
}

install_homebrew() {
    if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Homebrew installed successfully"
    else
        echo "Homebrew is already installed"
    fi
}

setup_zsh() {
    echo "Configuring Z Shell..."
    local zshrc="${DOTFILES_DIR}/zsh/zshrc.profile"
    if [[ -f "$zshrc" ]]; then
        ln -sf "$zshrc" ~/.zshrc
        echo "ZSH configuration linked successfully"
    else
        echo "ZSH profile not found at $zshrc"
        return 1
    fi
}

setup_zed() {
    echo "Configuring Zed Editor..."
    local zed_config="${DOTFILES_DIR}/zed/settings.json"
    local zed_dir=~/.config/zed

    if [[ -f "$zed_config" ]]; then
        mkdir -p "$zed_dir"
        ln -sf "$zed_config" "${zed_dir}/settings.json"
        echo "Zed configuration linked successfully"
    else
        echo "Zed settings not found at $zed_config"
        return 1
    fi
}

setup_git() {
    echo "Configuring Git..."
    git config --global user.name "$GIT_NAME"
    git config --global user.email "$GIT_EMAIL"
    echo "Git configuration updated successfully"
}

clone_repositories() {
    echo "Downloading personal GitHub repositories..."
    if [[ ! -f "$REPO_LIST" ]]; then
        echo "Repository list not found at $REPO_LIST"
        return 0
    fi

    while IFS= read -r repo_url || [[ -n "$repo_url" ]]; do
        [[ "$repo_url" =~ ^#.*$ || -z "$repo_url" ]] && continue

        local repo_name
        repo_name=$(echo "$repo_url" | awk -F'/' '{print $NF}' | sed 's/.git$//')
local target_path="${CODE_DIR}/${repo_name}"


        if [[ ! -d "$target_path" ]]; then
            echo "Cloning $repo_url..."
            git clone "$repo_url" "$target_path"
        else
            echo "Repository $repo_name already exists, skipping..."
        fi
    done < "$REPO_LIST"
}

setup_system() {
    install_homebrew
    setup_zsh
    setup_zed
    setup_git
    clone_repositories
}

refresh_system() {
    dump_homebrew
    update_homebrew
}

show_usage() {
    cat << EOF
Usage: $(basename "$0") <command>

Commands:
    dump    - Dump current Homebrew packages to Brewfile
    update  - Update and install Homebrew packages
    refresh - Sync Homebrew packages (dump & update)
    setup   - Set up system configurations
    all     - Perform all operations
    help    - Show this help message

Examples:
    $(basename "$0") setup
    $(basename "$0") all
EOF
    exit 1
}

main() {
    verify_directories

    case "${1:-help}" in
        "dump")    dump_homebrew ;;
        "update")  update_homebrew ;;
        "refresh") refresh_system ;;
        "setup")   setup_system ;;
        "all")
            setup_system
            refresh_system
            ;;
        *)       show_usage ;;
    esac
}

main "$@"
