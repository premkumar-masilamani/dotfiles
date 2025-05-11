#!/bin/bash

set -euo pipefail

# Configuration
readonly USERNAME="premkumar"
readonly DOTFILES_DIR="/Users/${USERNAME}/Code/dotfiles"
readonly CODE_DIR="/Users/${USERNAME}/Code"
readonly BREW_FILE="${DOTFILES_DIR}/homebrew/Brewfile"
readonly REPO_LIST="${DOTFILES_DIR}/github/repos.txt"
readonly GIT_NAME="Premkumar Masilamani"
readonly GIT_EMAIL="premkumar.masilamani.2020@gmail.com"

# Color codes for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m' # No Color

# Logging functions
log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }

# Error handler
trap 'log_error "An error occurred on line $LINENO. Exit code: $?"' ERR

# Check if running with sudo/root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        log_error "This script should not be run as root/sudo"
        exit 1
    fi
}

# Verify required directories exist
verify_directories() {
    local dirs=("$DOTFILES_DIR" "$CODE_DIR")
    for dir in "${dirs[@]}"; do
        if [[ ! -d "$dir" ]]; then
            log_info "Creating directory: $dir"
            mkdir -p "$dir"
        fi
    done
}

# Homebrew management
dump_homebrew() {
    log_info "Dumping Homebrew packages..."
    rm -f "${BREW_FILE}" "${BREW_FILE}.lock.json"
    brew bundle dump --file="$BREW_FILE"
    log_info "Brewfile updated successfully"
}

update_homebrew() {
    log_info "Updating Homebrew packages..."
    if [[ ! -f "$BREW_FILE" ]]; then
        log_error "Brewfile not found at $BREW_FILE"
        return 1
    fi
    
    brew bundle install --file="$BREW_FILE" && \
    brew update && \
    brew upgrade && \
    brew bundle --force cleanup --file="$BREW_FILE" && \
    brew services cleanup
    
    log_info "Homebrew packages updated successfully"
}

install_homebrew() {
    if ! command -v brew &>/dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        log_info "Homebrew installed successfully"
    else
        log_info "Homebrew is already installed"
    fi
}

# System configuration
setup_zsh() {
    log_info "Configuring Z Shell..."
    local zshrc="${DOTFILES_DIR}/zsh/zshrc.profile"
    if [[ -f "$zshrc" ]]; then
        ln -sf "$zshrc" ~/.zshrc
        log_info "ZSH configuration linked successfully"
    else
        log_error "ZSH profile not found at $zshrc"
        return 1
    fi
}

setup_zed() {
    log_info "Configuring Zed Editor..."
    local zed_config="${DOTFILES_DIR}/zed/settings.json"
    local zed_dir=~/.config/zed
    
    if [[ -f "$zed_config" ]]; then
        mkdir -p "$zed_dir"
        ln -sf "$zed_config" "${zed_dir}/settings.json"
        log_info "Zed configuration linked successfully"
    else
        log_error "Zed settings not found at $zed_config"
        return 1
    fi
}

setup_git() {
    log_info "Configuring Git..."
    git config --global user.name "$GIT_NAME"
    git config --global user.email "$GIT_EMAIL"
    log_info "Git configuration updated successfully"
}

clone_repositories() {
    log_info "Downloading personal GitHub repositories..."
    if [[ ! -f "$REPO_LIST" ]]; then
        log_warn "Repository list not found at $REPO_LIST"
        return 0
    fi
    
    while IFS= read -r repo_url || [[ -n "$repo_url" ]]; do
        [[ "$repo_url" =~ ^#.*$ || -z "$repo_url" ]] && continue
        
        local repo_name
        repo_name=$(echo "$repo_url" | awk -F'/' '{print $NF}' | sed 's/.git$//')
        local target_path="${CODE_DIR}/${repo_name}"
        
        if [[ ! -d "$target_path" ]]; then
            log_info "Cloning $repo_url..."
            git clone "$repo_url" "$target_path"
        else
            log_info "Repository $repo_name already exists, skipping..."
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

show_usage() {
    cat << EOF
Usage: $(basename "$0") <command>

Commands:
    dump   - Dump current Homebrew packages to Brewfile
    update - Update and install Homebrew packages
    setup  - Set up system configurations
    all    - Perform all operations
    help   - Show this help message

Examples:
    $(basename "$0") setup
    $(basename "$0") all
EOF
    exit 1
}

main() {
    check_root
    verify_directories
    
    case "${1:-help}" in
        "dump")   dump_homebrew ;;
        "update") update_homebrew ;;
        "setup")  setup_system ;;
        "all")    
            setup_system
            dump_homebrew
            update_homebrew
            ;;
        *)       show_usage ;;
    esac
}

main "$@"