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
compinit
# End of lines added by compinstall

# ZSH Prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats ' %s(%b)'
precmd () { vcs_info }
setopt prompt_subst
PROMPT='%F{41}%~%f ${vcs_info_msg_0_} '

# Homebrew setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# Environment Variables
export PATH="/opt/homebrew/opt/openjdk@21/bin:/opt/homebrew/opt/node@20/bin:$(go env GOPATH)/bin:$HOME/.cargo/bin:$PATH"
export JAVA_HOME=/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@21/include"

# D2 TALA config
export TSTRUCT_TOKEN=tstruct_eyJ2ZXJzaW9uIjoxLCJkYXRhIjp7InVzZXJJRCI6MSwidXNlckVtYWlsIjoiY2xvdWQtYWRtaW5Ac2licm9zLnRlY2giLCJ0ZWFtSUQiOjEsInRlYW1OYW1lIjoiY2xvdWQtYWRtaW5Ac2licm9zLnRlY2giLCJyZW5ld2FsRGF0ZSI6IjIwMjQtMDYtMjlUMjE6Mjg6MDVaIiwiY3JlYXRlZEF0IjoiMjAyMy0wNi0yOVQyMToyODowOS43MjYyMjgxMjFaIn0sInNpZ25hdHVyZSI6ImZlRUI2NHltSHpyUFdJaUkweWhOTEFMSG5rcjRMUUYrdzZXTTBqREdTZUVORW5MV3gwWS9iQVExNm8vTjhMUmw3Q01ZQ0tzT0ZDNW0xS1ZUSDc2bkNRPT0ifQ==

# Github Personal Access Token
export GH_TOKEN=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

# Google Gemini API Key
# Used in Generative AI SDK (Coaching Summaries)
export GEMINI_API_KEY_UNUSED=AIzaSyBUEFEkjCd0Z0vNa0BHTuSsOo5_gaQukFE
# Used in Zed Editor (Code Assist)
export GOOGLE_AI_API_KEY_UNUSED=AIzaSyAmLP7pVoN0tOxXGBzfpxlG7SvEvjQI-MI

# Hugging Face User Access Token
export HUGGINGFACE_UAT=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

# Utility Softwares
alias top='htop'
alias du='ncdu --color dark -rr -x'
alias flushdns='sudo killall -HUP mDNSResponder'
alias profile='zed ~/.zshrc'
alias reload='source ~/.zshrc'
alias chrome='open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security'

# Python aliases
alias python=/usr/local/bin/python3
alias pip=/usr/local/bin/pip3

# Git aliases
alias gcm='git checkout main; git pull; git submodule update'
alias gl="git log --pretty=format:'%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s' --date=short"
alias grs='git reset --soft HEAD~1'
alias grh='git reset --hard HEAD~1'

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
