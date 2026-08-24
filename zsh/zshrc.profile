# =========================================================
# Homebrew
# =========================================================
# Dedicated to Apple Silicon (arm64) Macs.

export HOMEBREW_PREFIX="/opt/homebrew"

# Core Homebrew initialization (Sets up internal vars securely)
eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

# =========================================================
# PATH & Environment Variables
# =========================================================

typeset -U path PATH

path=(
  "$HOMEBREW_PREFIX/bin"
  "$HOMEBREW_PREFIX/sbin"
  "$HOMEBREW_PREFIX/opt/openjdk/bin"
  "$HOMEBREW_PREFIX/opt/node@22/bin"
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$HOME/go/bin"
  $path
)

export PATH

export JAVA_HOME="$HOMEBREW_PREFIX/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
export LDFLAGS="-L$HOMEBREW_PREFIX/opt/node@22/lib"
export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/node@22/include"

# =========================================================
# History
# =========================================================

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY

# =========================================================
# Completion System
# =========================================================

autoload -Uz compinit

ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$ZSH_CACHE_DIR"

if [[ -f "$ZSH_CACHE_DIR/.zcompdump" ]]; then
  compinit -C -d "$ZSH_CACHE_DIR/.zcompdump"
else
  compinit -d "$ZSH_CACHE_DIR/.zcompdump"
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

unset ZSH_CACHE_DIR

# =========================================================
# Prompt & Appearance
# =========================================================

builtin autoload -Uz vcs_info
builtin autoload -Uz colors && colors

# Configure Git branch detection
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' on %F{magenta} %b%f'

# Update VCS info before each prompt display
precmd() {
  vcs_info
}

# Allow parameter expansion and command substitution in PROMPT
setopt PROMPT_SUBST

# Prompt layout:
# Line 1: full path on  branch
# Line 2: ❯ (green on success, red on error)
PROMPT='%F{cyan}%~%f${vcs_info_msg_0_}
%(?.%F{green}.%F{red})❯%f '

# =========================================================
# Atuin History
# =========================================================

if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh)"
fi

# =========================================================
# Secrets
# =========================================================

DOTFILES_SECRETS_FILE="$HOME/zshrc.secrets"

if [[ -f "$DOTFILES_SECRETS_FILE" ]]; then
  set -a
  source "$DOTFILES_SECRETS_FILE"
  set +a
fi

unset DOTFILES_SECRETS_FILE

# =========================================================
# Aliases
# =========================================================

alias du='ncdu --enable-shell --color dark -rr -x'
alias flushdns='sudo killall -HUP mDNSResponder'

alias profile='zed ~/.zshrc'
alias reload='source ~/.zshrc'

# Dangerous Chrome profile
alias chrome-insecure='open -n -a "Google Chrome" --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security'

# Safer defaults
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# =========================================================
# Git Aliases
# =========================================================

alias gcm='git switch main && git pull --rebase origin main && git submodule update --init --recursive'
alias gf='git fetch --all --prune'
alias gl='git log --graph --pretty=format:"%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s" --date=short'

gc() {
  [[ -n "$1" ]] || {
    echo "Usage: gc <branch>"
    return 1
  }

  git switch "$1"
}

# =========================================================
# Git Helpers
# =========================================================

git_inside_repo() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1
}

git_undo_last_commit_local() {
  git_inside_repo || {
    echo "Not inside a git repository."
    return 1
  }

  echo "This will undo the last commit but keep changes staged."
  git --no-pager log -1 --oneline || return 1

  echo
  read -r "REPLY?Type 'yes' to continue: "
  echo

  [[ "$REPLY" == "yes" ]] || {
    echo "Aborted."
    return 1
  }

  git reset --soft HEAD~1
}

git_delete_last_commit_local() {
  git_inside_repo || {
    echo "Not inside a git repository."
    return 1
  }

  echo "This will permanently delete the last commit locally."
  git --no-pager log -1 --oneline || return 1

  echo
  read -r "REPLY?Type 'yes' to continue: "
  echo

  [[ "$REPLY" == "yes" ]] || {
    echo "Aborted."
    return 1
  }

  git reset --hard HEAD~1
}

git_rebase_and_push() {
  git_inside_repo || {
    echo "Not inside a git repository."
    return 1
  }

  local base="${1:-main}"

  echo "Rebasing current branch onto origin/$base"
  git --no-pager log -1 --oneline || return 1

  echo
  read -r "REPLY?About to rebase onto origin/$base. Type 'yes' to continue: "
  echo

  [[ "$REPLY" == "yes" ]] || {
    echo "Rebase aborted."
    return 1
  }

  git fetch origin || return 1
  git rebase "origin/$base" || return 1

  echo
  read -r "REPLY?Rebase completed. About to force push with --force-with-lease. Type 'yes' to continue: "
  echo

  [[ "$REPLY" == "yes" ]] || {
    echo "Force push aborted."
    return 1
  }

  git push --force-with-lease
}

# =========================================================
# Project Shortcuts
# =========================================================

alias dot='zed "$HOME/Code/dotfiles"'
alias blog='zed "$HOME/Code/premkumar-masilamani.github.io"'
