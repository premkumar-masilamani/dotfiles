# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/smileprem/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# ZSH Prompt
source <(kubectl completion zsh)
source /Users/smileprem/Code/personal/kube-ps1/kube-ps1.sh

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats ' %s(%b)'
precmd () { vcs_info }
setopt prompt_subst

PROMPT='%F{41}%~%f ${vcs_info_msg_0_} $(kube_ps1) '


# ZSH Utilities
source /Users/smileprem/Library/Preferences/org.dystroy.broot/launcher/bash/br

# Path Settings
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=~/.cargo/bin:~/.poetry/bin:~/Softwares:~/Softwares/google-cloud-sdk/bin:/usr/local/opt/llvm@8/bin:/Users/smileprem/bin:/Users/smileprem/bin/gcc-arm-none-eabi-8-2019-q3-update/bin:/Users/smileprem/.local/bin:${KREW_ROOT:-$HOME/.krew}/bin:$GOROOT:$GOROOT/bin:$GOPATH:$GOPATH/bin:$GOBIN:$PATH

# Google Backend API Configurations
export GOOGLE_APPLICATION_CREDENTIALS=/Users/smileprem/Documents/Sibros/Credentials/sibros-staging-259522-cloud-development.json
export PROJECT_ID=sibros-staging-259522
export BUCKET_APPSPOT=sibros-staging-259522.appspot.com
export BUCKET_RAW_LOGS=sibros-staging-raw-logs
export BUCKET_RAW_DASHBOARD_LOGS=sibros-staging-proto-dashboard-logs
export KMS_KEY_RING=staging
export KMS_KEY_LOCATION=global
export KMS_KEY=cloud_key
export ENCODED_FILE=sibros-staging.enc

#export SERVICE_CONFIG_PATH=/Users/smileprem/go/src/gitlab.com/sibros/cloud/backend/services/cloudapi/config/config.local.yaml
#export ATLAS_CONFIG_PATH=/Users/smileprem/go/src/gitlab.com/sibros/cloud/backend/services/atlas/config/config.local.yaml

# Gitlab CI config
export GITLAB_USER=smileprem@gitlab.com
export GITLAB_TOKEN=uFjtGau3GhzAFVy4s7py
export CI_JOB_TOKEN=uFjtGau3GhzAFVy4s7py

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

# Kubernetes App Logs
alias klo='kubectl logs -f deployments/olympus -n sibros-apps'
alias kltg='kubectl logs -f deployments/the-guardian -n sibros-apps'
alias kla='kubectl logs -f deployments/atlas -n sibros-apps'
alias klbs='kubectl logs -f deployments/bajaj-service -n sibros-apps'
alias klc='kubectl logs -f deployments/cantools-api -n sibros-apps'
alias kld='kubectl logs -f deployments/director -n sibros-apps'
alias klcr='kubectl logs -f deployments/chronos -n sibros-apps'
alias kldsr='kubectl logs -f deployments/director-notary-server -n sibros-apps'
alias kldsn='kubectl logs -f deployments/director-notary-signer -n sibros-apps'
alias klisr='kubectl logs -f deployments/image-notary-server -n sibros-apps'
alias klisn='kubectl logs -f deployments/image-notary-signer -n sibros-apps'
alias klg='kubectl logs -f deployments/grafana -n sibros-apps'
alias klh='kubectl logs -f deployments/hasura-graphql -n sibros-apps'
alias klhm='kubectl logs -f deployments/hasura-graphql-mobile -n sibros-apps'

# Kubernetes Infra Logs
alias kln='kubectl logs -f deployments/nginx-ingress-controller -n sibros-infra'
alias klca='kubectl logs -f deployments/cluster-autoscaler -n kube-system'

# Kubernetes Pods - General
alias bb='kubectl run -i --tty busybox --image=yauritux/busybox-curl --restart=Never --rm -- sh'

# Kubernetes Pods - Olympus DB
alias local-olympus-db='pgcli "postgres://postgres_user:postgres_password@localhost:5432/olympus?sslmode=disable"'
alias sibros-dev-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:Cs6h2qwI6V4Ypfg@us-west-2-rds-cluster.cluster-cmsezeuapyek.us-west-2.rds.amazonaws.com:5432/cloudapi'
alias sibros-staging-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:knd958vXDPzUkLv@us-west-2-rds-cluster.cluster-cvwbr9hwsmni.us-west-2.rds.amazonaws.com:5432/cloudapi'
alias sibros-prod-olympus-db='echo no olympus db for sibros prod'
alias sibros-demo-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:LvV77YxRvHMBk9FG@us-west-2-rds-cluster.cluster-c6aj9ugrsy9v.us-west-2.rds.amazonaws.com:5432/cloudapi'
alias bajaj-dev-olympus-db='echo no olympus db for bajaj dev'
alias bajaj-prod-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:12Ykl8st8QVDK0J@ap-south-1-olympus-cluster.cluster-c9ltpnagyuxt.ap-south-1.rds.amazonaws.com:5432/cloudapi'
alias lyft-prod-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:naW4GXjrmZ328Bf@us-west-2-rds-cluster-olympus.cluster-cq7fqrw6ubxv.us-west-2.rds.amazonaws.com:5432/cloudapi'
alias lightyear-dev-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:66FeBcuHFvX4acT9@eu-central-1-rds-cluster.cluster-cohrmnxfrmlt.eu-central-1.rds.amazonaws.com:5432/cloudapi'
alias harleydavidson-dev-olympus-db='echo no olympus db for harleydavidson-dev'
alias jcb-dev-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:MAJLbvrX7fmpg4hm@us-west-2-rds-cluster.cluster-c0gcpiz6bgpx.us-west-2.rds.amazonaws.com:5432/cloudapi'

# Kubernetes Pods - Timescale DB
alias local-timescale-db='pgcli "postgres://timescale_user:timescale_password@localhost:5433/postgres?sslmode=disable"'
alias sibros-dev-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:34HJjT9zxnN65h9@timescaledb-single.sibros-dbs.svc.cluster.local:5432/postgres'
alias sibros-staging-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:FTjM04UwyFcp7lF@timescaledb-single.sibros-dbs.svc.cluster.local:5432/postgres'
alias sibros-prod-timescale-db='echo no timescale db for sibros prod'
alias sibros-demo-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:22mQfbymLtDKyF3Z@timescaledb-cluster.sibros-dbs.svc.cluster.local:5432/postgres'
alias bajaj-dev-timescale-db='echo no timescale db for bajaj dev'
alias bajaj-prod-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:D2cYe2Fq8yJ5oVn@timescaledb-single.sibros-dbs.svc.cluster.local:5432/postgres'
alias lyft-prod-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:eeH9782Cyzet@timescaledb-single.sibros-dbs.svc.cluster.local:5432/postgres'
alias lightyear-dev-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:DVqXwcB36EgVVubg@timescaledb-cluster.sibros-dbs.svc.cluster.local:5432/postgres'
alias harleydavidson-dev-timescale-db='echo no timescale db for harleydavidson-dev'
alias jcb-dev-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:C5vZjFgrhPsjmCCY@timescaledb-cluster.sibros-dbs.svc.cluster.local:5432/postgres'

# Kubernetes Pods - Mobile DB
alias local-mobile-db='pgcli "postgres://mobile_user:mobile_password@localhost:5434/mobiledb?sslmode=disable"'
alias sibros-dev-mobile-db='kubectl run -i --tty mobile-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:y7cTYP72P5muZm2g@us-west-2-mobile-db-cluster.cluster-cmsezeuapyek.us-west-2.rds.amazonaws.com:5432/mobiledb'
alias sibros-staging-mobile-db='kubectl run -i --tty mobile-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://postgres:Q2KU6Q3NLJ8xfRTM@us-west-2-mobile-db-cluster.cluster-cvwbr9hwsmni.us-west-2.rds.amazonaws.com:5432/mobiledb'
alias sibros-prod-mobile-db='echo no mobile db for sibros prod'
alias sibros-demo-mobile-db='echo no mobile db for sibros demo'
alias bajaj-dev-mobile-db='echo no mobile db for bajaj prod'
alias bajaj-prod-mobile-db='kubectl run -i --tty mobile-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:9AsVciR8PRUNe4x@ap-south-1-mobile-db-cluster.cluster-c9ltpnagyuxt.ap-south-1.rds.amazonaws.com:5432/mobiledb'
alias lyft-prod-mobile-db='echo no mobile db for lyft prod'
alias lightyear-dev-mobile-db='echo no mobile db for lightyear-dev'
alias harleydavidson-dev-mobile-db='echo no mobile db for harleydavidson-dev'
alias jcb-dev-mobile-db='echo no mobile db for jcb-dev'

# Terraform Aliases
alias t='terraform'
alias ti='terraform init'
alias tp='terraform plan'
alias ta='terraform apply'

# AWS Projects
alias sibros-master='cd /Users/smileprem/Code/sibros/infrastructure/aws/sibros/master;export AWS_PROFILE=sibros-master;kubectl config unset current-context'
alias sibros-logarchive='cd /Users/smileprem/Code/sibros/infrastructure/aws/sibros/logarchive;export AWS_PROFILE=sibros-logarchive;kubectl config unset current-context'
alias sibros-audit='cd /Users/smileprem/Code/sibros/infrastructure/aws/sibros/audit;export AWS_PROFILE=sibros-audit;kubectl config unset current-context'
alias sibros-infra='cd /Users/smileprem/Code/sibros/infrastructure/aws/sibros/infra;export AWS_PROFILE=sibros-infra;kubectl config unset current-context'
alias sibros-interview='cd /Users/smileprem/Code/sibros/infrastructure/aws/sibros/interview;export AWS_PROFILE=sibros-interview;kubectl config unset current-context'

alias sibros-dev='cd /Users/smileprem/Code/sibros/infrastructure/aws/sibros/dev;export AWS_PROFILE=sibros-dev;kc sibros-dev'
alias sibros-staging='cd /Users/smileprem/Code/sibros/infrastructure/aws/sibros/staging;export AWS_PROFILE=sibros-staging;kc sibros-staging'
alias sibros-prod='cd /Users/smileprem/Code/sibros/infrastructure/aws/sibros/prod;export AWS_PROFILE=sibros-prod;kubectl config unset current-context'
alias sibros-demo='cd /Users/smileprem/Code/sibros/infrastructure/aws/sibros/demo;export AWS_PROFILE=sibros-demo;kc sibros-demo'

alias bajaj-dev='cd /Users/smileprem/Code/sibros/infrastructure/aws/bajaj/dev;export AWS_PROFILE=bajaj-dev;kc bajaj-dev'
alias bajaj-prod='cd /Users/smileprem/Code/sibros/infrastructure/aws/bajaj/prod;export AWS_PROFILE=bajaj-prod;kc bajaj-prod'

alias lyft-prod='cd /Users/smileprem/Code/sibros/infrastructure/aws/lyft/prod;export AWS_PROFILE=lyft-prod;kc lyft-prod'
alias lightyear-dev='cd /Users/smileprem/Code/sibros/infrastructure/aws/lightyear/dev;export AWS_PROFILE=lightyear-dev;kc lightyear-dev'
alias harleydavidson-dev='cd /Users/smileprem/Code/sibros/infrastructure/aws/harleydavidson/dev;export AWS_PROFILE=harleydavidson-dev;kc harleydavidson-dev'
alias jcb-dev='cd /Users/smileprem/Code/sibros/infrastructure/aws/jcb/dev;export AWS_PROFILE=jcb-dev;kc jcb-dev'

# Azure Projects
alias azbajaj='cd /Users/smileprem/Code/sibros/infrastructure/azure/bajaj/dev;az account set -s 47d0c041-5d78-4c12-8f4e-2363f798e807;'
alias azdev='cd /Users/smileprem/Code/sibros/infrastructure/azure/sibros/dev;az account set -s 9b72bbcd-7e7b-48b0-acda-14e60a9de11e;'

# Utility Softwares
alias top='htop'
alias du='ncdu --color dark -rr -x'
alias help='tldr'
alias ping='prettyping --nolegend'
alias flushdns='sudo killall -HUP mDNSResponder'
alias proto='rm -rf ~/protodot/ && protodot -src ~/go/src/gitlab.com/sibros/cloud/backend/interop/proto/sibros/deep_logger/live_logger.proto -output live_logger && protodot -src ~/go/src/gitlab.com/sibros/cloud/backend/interop/proto/sibros/deep_updater/cloud.proto && protodot -src ~/go/src/gitlab.com/sibros/cloud/backend/interop/proto/sibros/deep_updater/uptane.proto && protodot -src ~/go/src/gitlab.com/sibros/cloud/backend/interop/proto/customers/lyft/*.proto'
alias profile='code /Users/smileprem/Code/personal/dotfiles/.zshrc'
alias reload='source ~/.zshrc'

# Python aliases
alias python=/usr/local/bin/python3
alias pip=/usr/local/bin/pip3

# Git aliases
alias gcm='git checkout master; git pull'

# Directory aliases
alias fe='cd /Users/smileprem/Code/sibros/frontend'
alias be='cd /Users/smileprem/go/src/gitlab.com/sibros/cloud/backend'
alias infra='cd /Users/smileprem/Code/sibros/infrastructure'
alias not='cd /Users/smileprem/go/src/gitlab.com/sibros/cloud/notary'
alias plat='cd /Users/smileprem/Code/sibros/platform'
alias cred='cd /Users/smileprem/Documents/Sibros/Credentials'

# Make some possibly destructive commands more interactive.
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# Make grep more user friendly by highlighting matches
# and exclude grepping through .svn folders.
alias grep='grep --color=auto --exclude-dir=\.git'

# Functions
print_tls() {
  echo | openssl s_client -connect $1:443 < /dev/null 2>/dev/null | openssl x509 -noout -text
}


# The next line enables shell command completion for gcloud.
if [ -f '/Users/smileprem/Softwares/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/smileprem/Softwares/google-cloud-sdk/completion.zsh.inc'; fi

export PATH=$PATH:/usr/local/Cellar/llvm@8/8.0.1/bin
export PATH=$PATH:/Users/smileprem/.gem/ruby/2.6.0/bin
export PATH=$PATH:/Users/smileprem/.local/bin
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH=$PATH:/usr/local/anaconda3/bin
export PATH=/usr/local/opt/llvm@8/bin:$PATH
export PATH=$PATH:/Users/smileprem/bin
export PATH=$PATH:/Users/smileprem/bin/gcc-arm-none-eabi-8-2019-q3-update/bin
export PATH=$PATH:/Library/Tex/texbin
export PATH="/usr/local/opt/ncurses/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
