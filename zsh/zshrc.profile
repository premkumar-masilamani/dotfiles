# Shell History Settings
HISTSIZE=100000
SAVEHIST=100000
HISTORY_IGNORE="(ls|cd|pwd|exit|brew|clear|chmod)*"

setopt EXTENDED_HISTORY      # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY    # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY         # Share history between all sessions.
setopt HIST_IGNORE_DUPS      # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS  # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE     # Do not record an event starting with a space.
setopt HIST_FIND_NO_DUPS      # Do not display duplicates during history search
setopt HIST_SAVE_NO_DUPS     # Do not write a duplicate event to the history file.
setopt HIST_VERIFY           # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY        # append to history file (Default)
setopt HIST_NO_STORE         # Don't store history commands
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from each command line being added to the history.

# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$ZSH_CACHE_DIR"
compinit -d "${ZSH_CACHE_DIR}/.zcompdump" -C
unset ZSH_CACHE_DIR
# End of lines added by compinstall

# ZSH Prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats ' %s(%b)'
precmd () { vcs_info }
setopt prompt_subst
PROMPT='%F{41}%~%f ${vcs_info_msg_0_} '

# Homebrew setup
if [[ -x /opt/homebrew/bin/brew ]] && [[ -z "${HOMEBREW_PREFIX:-}" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Environment Variables
typeset -U path
path=(
  /opt/homebrew/opt/openjdk@21/bin
  /opt/homebrew/opt/node@20/bin
  "$HOME/go/bin"
  "$HOME/.cargo/bin"
  "$HOME/.local/bin"
  $path
)
export PATH
export JAVA_HOME=/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@21/include"

# Local secrets (not tracked in git).
if [[ -f "$HOME/.zshrc.secrets" ]]; then
  source "$HOME/.zshrc.secrets"
fi

# Utility Softwares
alias top='htop'
alias du='ncdu --color dark -rr -x'
alias flushdns='sudo killall -HUP mDNSResponder'
alias profile='zed ~/.zshrc'
alias reload='source ~/.zshrc'
alias chrome='open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security'

# Python aliases
# alias python=/usr/local/bin/python3
# alias pip=/usr/local/bin/pip3

# Git aliases
alias gcm='git checkout main && git pull --rebase origin main && git submodule update --init --recursive'
alias gf='git fetch --all --prune'
alias gl='git log --graph --pretty=format:"%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s" --date=short'

git_undo_last_commit_local() {
  echo "This will undo the last commit but keep changes staged."
  git --no-pager log -1 --oneline || return 1
  echo

  read "REPLY?Type 'yes' to continue: "
  echo
  [[ "$REPLY" == "yes" ]] || {
    echo "Aborted."
    return 1
  }

  git reset --soft HEAD~1
}

git_delete_last_commit_local() {
  echo "This will permanently delete the last commit locally."
  git --no-pager log -1 --oneline || return 1
  echo

  read "REPLY?Type 'yes' to continue: "
  echo
  [[ "$REPLY" == "yes" ]] || {
    echo "Aborted."
    return 1
  }

  git reset --hard HEAD~1
}

git_rebase_and_push() {
  local base="${1:-main}"

  echo "Rebasing current branch onto origin/$base"
  git --no-pager log -1 --oneline || return 1
  echo

  # Confirm rebase
  read "REPLY?About to rebase onto origin/$base. Type 'yes' to continue: "
  echo
  [[ "$REPLY" == "yes" ]] || {
    echo "Rebase aborted."
    return 1
  }

  git fetch origin || return 1
  git rebase "origin/$base" || return 1

  echo

  # Confirm force push
  read "REPLY?Rebase completed. About to force push with --force-with-lease. Type 'yes' to continue: "
  echo
  [[ "$REPLY" == "yes" ]] || {
    echo "Force push aborted."
    return 1
  }

  git push --force-with-lease
}

gc() {
  git switch "$1"
}

# Directory aliases
alias dot='zed ~/Code/dotfiles'
alias blog='zed ~/Code/premkumar-masilamani.github.io'

# OLLAMA aliases
alias ols="ollama ls"
alias ops="ollama ps"
alias opull="ollama pull"
alias orun="ollama run"
alias ostop="ollama stop"
alias orm="ollama rm"
