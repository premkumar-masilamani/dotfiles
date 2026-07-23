#!/bin/bash

set -euo pipefail

# Configuration
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DOTFILES_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
readonly CODE_DIR="${CODE_DIR:-${HOME}/Documents/Code}"

# This configuration is designed for Apple Silicon (arm64) Macs only.
if [[ "$(uname -m)" != "arm64" ]]; then
    echo "Error: This configuration is designed for Apple Silicon (arm64) Macs only." >&2
    exit 1
fi

readonly BREW_PREFIX="/opt/homebrew"
readonly BREW_FILE="${DOTFILES_DIR}/homebrew/Brewfile"

readonly GIT_USERNAME="premkumar-masilamani"
readonly GIT_NAME="Premkumar Masilamani"
readonly GIT_EMAIL="premkumar.masilamani.2020@gmail.com"

verify_directories() {
    local dirs=("$CODE_DIR" "$DOTFILES_DIR")
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
    if ! command -v brew &>/dev/null; then
        echo "Homebrew is not installed. Run setup first."
        return 1
    fi

    if [[ ! -f "$BREW_FILE" ]]; then
        echo "Brewfile not found at $BREW_FILE"
        return 1
    fi

    brew update --verbose
    brew bundle install --file="$BREW_FILE" --verbose
    brew bundle cleanup --file="$BREW_FILE" --force --verbose
    brew services cleanup --verbose

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

    # Ensure brew is available in the current shell (its prefix
    # differs by architecture: /opt/homebrew vs /usr/local).
    if [[ -x "${BREW_PREFIX}/bin/brew" ]]; then
        eval "$("${BREW_PREFIX}/bin/brew" shellenv)"
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
    git config --global push.autoSetupRemote true
    git config --global advice.forceDeleteBranch false
    git config --global pull.rebase true
    echo "Git configuration updated successfully"
}

clone_repositories() {
    if ! command -v gh &>/dev/null; then
        echo "GitHub CLI (gh) is not installed. Skipping repository cloning."
        return 0
    fi

    echo "Downloading personal GitHub repositories using GitHub CLI..."
    mkdir -p "$CODE_DIR"
    cd "$CODE_DIR" || return

    gh repo list "$GIT_USERNAME" --limit 1000 --json nameWithOwner,sshUrl --jq '.[] | "\(.nameWithOwner) \(.sshUrl)"' |
    while read -r full_name ssh_url; do
      local repo_dir
      repo_dir=$(basename "$full_name")
      if [[ -d "$repo_dir" ]]; then
          echo "Skipping already cloned repo: $repo_dir"
      else
          echo "Cloning $full_name..."
          git clone "$ssh_url"
      fi
    done

    echo "All repositories cloned to $CODE_DIR"
}

update_rulesets_github() {
    if ! command -v gh &>/dev/null; then
        echo "GitHub CLI (gh) is not installed. Skipping GitHub ruleset updates."
        return 0
    fi

    echo "Enforcing protection on main branch (solo-developer mode)..."

    local repos
    # Fetching repositories for the user
    if ! repos=$(gh repo list "$GIT_USERNAME" --limit 200 --json nameWithOwner -q '.[].nameWithOwner'); then
        echo "Failed to load repositories. Ensure gh is authenticated."
        return 1
    fi

    if [[ -z "$repos" ]]; then
        echo "No repositories found for $GIT_USERNAME."
        return 0
    fi

    for repo in $repos; do
        echo "Processing $repo ..."

        # 1. Apply Branch Protection
        # - Reviews are set to null (No blocking 'Review Required' errors)
        # - allow_force_pushes/allow_deletions set to false (The core safety rules)
        if gh api \
            --method PUT \
            -H "Accept: application/vnd.github+json" \
            "/repos/$repo/branches/main/protection" \
            --input - <<EOF
{
  "enforce_admins": false,
  "required_pull_request_reviews": null,
  "restrictions": null,
  "required_status_checks": null,
  "allow_force_pushes": false,
  "allow_deletions": false
}
EOF
        then
            echo "  → main branch protected (Force-push/Deletion disabled; Solo PRs allowed)."
        else
            echo "  → Failed to protect main branch for $repo. (Check if 'main' exists)"
            continue
        fi

        # 2. Enable automatic branch deletion on merge
        if gh api \
            --method PATCH \
            -H "Accept: application/vnd.github+json" \
            "/repos/$repo" \
            -f delete_branch_on_merge=true
        then
            echo "  → Automatic branch deletion enabled."
        else
            echo "  → Failed to enable automatic branch deletion for $repo."
        fi
    done

    echo "---"
    echo "Github Rules are updated for all the repos."
}

setup_system() {
    install_homebrew
    setup_zsh
    setup_zed
    setup_git
    update_homebrew
    clone_repositories
    update_rulesets_github
}

all_system() {
    setup_system
    dump_homebrew
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
    all     - Setup system and refresh Brewfile snapshot
    help    - Show this help message

Examples:
    $(basename "$0") setup
    $(basename "$0") all
EOF
    exit 1
}

main() {
    verify_directories

    echo "Homebrew prefix: ${BREW_PREFIX}"
    echo "Using Brewfile: ${BREW_FILE}"

    case "${1:-help}" in
        "dump")    dump_homebrew ;;
        "update")  update_homebrew ;;
        "refresh") refresh_system ;;
        "setup")   setup_system ;;
        "all")     all_system ;;
        *)       show_usage ;;
    esac
}

main "$@"
