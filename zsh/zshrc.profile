# Shell History Settings
HISTFILE="/Users/prem/Code/personal/dotfiles/zsh/zsh_history.txt"
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

eval "$(fzf --zsh)"

# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# ZSH Prompt
# source <(kubectl completion zsh)
# source "/usr/local/Cellar/kube-ps1/0.9.0/share/kube-ps1.sh"
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats ' %s(%b)'
precmd () { vcs_info }
setopt prompt_subst
PROMPT='%F{41}%~%f ${vcs_info_msg_0_} '

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/usr/local/bin/brew shellenv)"

# Go Path Variables (install from package, not using brew)
export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
export GODEBUG=asyncpreemptoff=1

# Rust Cargo Path Variables
export PATH=~/.cargo/bin:$PATH

# Kubectl Krew Path Variables
# export PATH=~/.krew/bin:$PATH

# Custom Software Path Variables
# export PATH=~/Softwares:~/Softwares/google-cloud-sdk/bin:$PATH

# Local Path Variables
export PATH=/opt/homebrew/opt/openjdk/bin:/opt/homebrew/opt/ncurses/bin:/opt/homebrew/opt/sqlite/bin:/opt/homebrew/opt/libxml2/bin:$PATH

# D2 TALA config
export TSTRUCT_TOKEN=tstruct_eyJ2ZXJzaW9uIjoxLCJkYXRhIjp7InVzZXJJRCI6MSwidXNlckVtYWlsIjoiY2xvdWQtYWRtaW5Ac2licm9zLnRlY2giLCJ0ZWFtSUQiOjEsInRlYW1OYW1lIjoiY2xvdWQtYWRtaW5Ac2licm9zLnRlY2giLCJyZW5ld2FsRGF0ZSI6IjIwMjQtMDYtMjlUMjE6Mjg6MDVaIiwiY3JlYXRlZEF0IjoiMjAyMy0wNi0yOVQyMToyODowOS43MjYyMjgxMjFaIn0sInNpZ25hdHVyZSI6ImZlRUI2NHltSHpyUFdJaUkweWhOTEFMSG5rcjRMUUYrdzZXTTBqREdTZUVORW5MV3gwWS9iQVExNm8vTjhMUmw3Q01ZQ0tzT0ZDNW0xS1ZUSDc2bkNRPT0ifQ==

# Rust Aliases
alias rustbook='rustup docs --book'

# Docker Aliases
alias gpg='docker run -it --rm -u $(id -u):$(id -g) -e HOME -v "$HOME":"$HOME" -v "$(pwd)":"$(pwd)" -w "$(pwd)" dockerizedtools/gpg:2.2.20'

# KubeCtl Aliases
alias k='kubectl'
alias kc='kubectx'
alias kn='kubens'
alias kgp='kubectl get pods'
alias kgpw='kubectl get pods -w'
alias kgs='kubectl get secrets'
alias kgsw='kubectl get secrets -w'
alias ktp='kubectl top pods --containers'
alias ktn='kubectl top nodes'
alias knp='kubectl get pod -o=custom-columns=NODE:.spec.nodeName,NAME:.metadata.name --all-namespaces'
alias knr='kubectl get nodes --no-headers | awk '\''{print $1}'\'' | xargs -I {} sh -c '\''echo {} ; kubectl describe node {} | grep Allocated -A 5 | grep -ve Event -ve Allocated -ve percent -ve -- ; echo '\'''

# Kubernetes Pods - General
alias bb='kubectl run -ti --rm --restart=Never busybox-curl-$USER --image=yauritux/busybox-curl'
alias bbaws='kubectl run -ti --rm --restart=Never aws-cli-$USER --image=fstab/aws-cli'
alias k8dash='kubectl port-forward service/k8dash 4654:4654 -n sibros-apps'

# Terraform Aliases
alias t='terraform'
alias ti='terraform init'
alias tiu='terraform init -upgrade'
alias tp='terraform plan'
alias tip='terraform init;terraform plan'
alias ta='terraform apply'
alias tia='terraform init;terraform apply'
alias tv='terraform validate'

# Utility Softwares
alias top='htop'
alias du='ncdu --color dark -rr -x'
alias help='tldr'
alias flushdns='sudo killall -HUP mDNSResponder'
alias profile='code ~/.zshrc'
alias reload='source ~/.zshrc'
alias chrome='open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security'

# Python aliases
alias python=/usr/local/bin/python3
alias pip=/usr/local/bin/pip3
export PYTHONPATH="~/Code/sibros/odxtools:$PYTHONPATH"

# Git aliases
alias gcm='git checkout master; git pull; git submodule update'
alias gcmain='git checkout main; git pull; git submodule update'
alias gl="git log --pretty=format:'%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s' --date=short"
alias grs='git reset --soft HEAD~1'
alias grh='git reset --hard HEAD~1'

# Directory aliases
alias dot='cd ~/Code/personal/dotfiles'
alias blog='cd ~/Code/personal/english-blog.github.io'
alias tamil='cd ~/Code/personal/tamil-blog.github.io'

# Photography aliases
alias cr2jpg='for infile in *.CR2; do convert $infile $(echo $infile|sed -n "s/CR2$/jpg/p"); done'

# Utility Functions
dns() {
  nslookup -debug $1
}

print_tls() {
  echo | openssl s_client -connect $1:443 -showcerts -servername $1
}

cer_to_pem() {
  openssl x509 -inform der -in $1 -out $1.pem
}

pem_to_der() {
  openssl x509 -inform pem -in $1 -outform der -out $1.der
}

function kga {
  for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
    echo "Resource:" $i
    
    if [ -z "$1" ]
    then
        kubectl get --ignore-not-found ${i}
    else
        kubectl -n ${1} get --ignore-not-found ${i}
    fi
  done
}

gitlab_docker_login() {
	awk '/gitlab.com/{getline; getline; print $2}' ~/.netrc | docker login registry.gitlab.com -u pmasilamani@sibros.tech --password-stdin
}
