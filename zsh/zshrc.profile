# Shell History Settings
HISTFILE="/Users/smileprem/Code/personal/dotfiles/zsh/zsh_history.txt"
HISTSIZE=10000000
SAVEHIST=10000000
HISTORY_IGNORE="(ls|cd|pwd|exit|brew|clear|chmod)*"

setopt EXTENDED_HISTORY      # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY    # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY         # Share history between all sessions.
setopt HIST_IGNORE_DUPS      # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS  # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE     # Do not record an event starting with a space.
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
source <(kubectl completion zsh)
source "/usr/local/Cellar/kube-ps1/0.8.0/share/kube-ps1.sh"

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats ' %s(%b)'
precmd () { vcs_info }
setopt prompt_subst

PROMPT='%F{41}%~%f ${vcs_info_msg_0_} $(kube_ps1) '

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/usr/local/bin/brew shellenv)"

# Go Path Variables (install from package, not using brew)
export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
export GODEBUG=asyncpreemptoff=1

# Rust Cargo Path Variables
# export PATH=~/.cargo/bin:$PATH

# Python Poetry Path Variables
# export PATH=~/.local/bin:$PATH

# Kubectl Krew Path Variables
export PATH=~/.krew/bin:$PATH

# Custom Software Path Variables
# export PATH=~/Softwares:~/Softwares/google-cloud-sdk/bin:$PATH

# Local Path Variables
export PATH=/opt/homebrew/opt/openjdk/bin:/opt/homebrew/opt/ncurses/bin:/opt/homebrew/opt/sqlite/bin:/opt/homebrew/opt/libxml2/bin:$PATH

# Gitlab CI config
# export GITLAB_USER=smileprem@gitlab.com
# export GITLAB_TOKEN=uFjtGau3GhzAFVy4s7py
# export CI_JOB_TOKEN=uFjtGau3GhzAFVy4s7py

# Structurizr CLI
# export WORKSPACE_ID=57915
# export API_KEY=ee5e5955-ada9-4ab8-b477-1e1ef6267721
# export API_SECRET=b4c24d81-035f-4086-a7c9-7f0814295239
# export WORKSPACE_FILE=workspace.dsl

# D2 TALA config
export TSTRUCT_TOKEN=tstruct_eyJ2ZXJzaW9uIjoxLCJkYXRhIjp7InVzZXJJRCI6MSwidXNlckVtYWlsIjoiY2xvdWQtYWRtaW5Ac2licm9zLnRlY2giLCJ0ZWFtSUQiOjEsInRlYW1OYW1lIjoiY2xvdWQtYWRtaW5Ac2licm9zLnRlY2giLCJyZW5ld2FsRGF0ZSI6IjIwMjQtMDYtMjlUMjE6Mjg6MDVaIiwiY3JlYXRlZEF0IjoiMjAyMy0wNi0yOVQyMToyODowOS43MjYyMjgxMjFaIn0sInNpZ25hdHVyZSI6ImZlRUI2NHltSHpyUFdJaUkweWhOTEFMSG5rcjRMUUYrdzZXTTBqREdTZUVORW5MV3gwWS9iQVExNm8vTjhMUmw3Q01ZQ0tzT0ZDNW0xS1ZUSDc2bkNRPT0ifQ==

# Rust Aliases
alias rustbook='rustup docs --book'

# Docker Aliases
# alias gpg='docker run -it --rm -u $(id -u):$(id -g) -e HOME -v "$HOME":"$HOME" -v "$(pwd)":"$(pwd)" -w "$(pwd)" dockerizedtools/gpg:2.2.20'

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
# alias k8dash='kubectl port-forward service/k8dash 4654:4654 -n sibros-apps'

# Kubernetes App Logs
# alias klo='kubectl logs -f deployments/olympus -n sibros-apps'
# alias kltg='kubectl logs -f deployments/the-guardian -n sibros-apps'
# alias kla='kubectl logs -f deployments/atlas -n sibros-apps'
# alias klc='kubectl logs -f deployments/command-api -n sibros-apps'
# alias klm='kubectl logs -f deployments/mqtt-gateway -n sibros-apps'

# Kubernetes Infra Logs
# alias kln='kubectl logs -f deployments/nginx-ingress-controller -n sibros-infra'
# alias klnp='kubectl logs deployments/nginx-ingress-controller -n sibros-infra | jq -r ". | [(.timestamp),(.http.request.method),(.http.response.status_code),(.http.upstream.status_code),(.url.original)] | @csv" | column -t -s,'
# alias klca='kubectl logs -f deployments/cluster-autoscaler -n kube-system'

# Kubernetes Pods - General
alias bb='kubectl run -ti --rm --restart=Never busybox-curl-$USER --image=yauritux/busybox-curl'
alias bbaws='kubectl run -ti --rm --restart=Never aws-cli-$USER --image=fstab/aws-cli'

# Kubernetes Pods - Olympus DB
# alias local-olympus-db='pgcli "postgres://postgres_user:postgres_password@localhost:5432/olympus?sslmode=disable"'
# alias sibros-dev-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:Cs6h2qwI6V4Ypfg@us-west-2-rds-cluster.cluster-cmsezeuapyek.us-west-2.rds.amazonaws.com:5432/cloudapi'
# alias sibros-staging-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:knd958vXDPzUkLv@us-west-2-rds-cluster.cluster-cvwbr9hwsmni.us-west-2.rds.amazonaws.com:5432/cloudapi'
# alias sibros-demo-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:LvV77YxRvHMBk9FG@us-west-2-rds-cluster.cluster-c6aj9ugrsy9v.us-west-2.rds.amazonaws.com:5432/cloudapi'
# alias sibros-preprod-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:jcFXephGJn5KSQGj@us-west-2-rds-cluster.cluster-cmwazx98tfqg.us-west-2.rds.amazonaws.com:5432/cloudapi'
# alias sibros-preprod-ap-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:Y7Duqd7Rm7hIyM2r@ap-south-1-rds-cluster.cluster-ca8mjuqk0je9.ap-south-1.rds.amazonaws.com:5432/cloudapi'
# alias sibros-preprod-eu-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:CEq5yVQFs2aTuUvq@eu-central-1-rds-cluster.cluster-c9pyzp86giv8.eu-central-1.rds.amazonaws.com:5432/cloudapi'
# alias bajaj-dev-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:66FeBcuHFvX4acT9@ap-south-1-rds-cluster-instance-0.cszdn7qvjkhc.ap-south-1.rds.amazonaws.com:5432/cloudapi'
# alias bajaj-prod-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:12Ykl8st8QVDK0J@ap-south-1-olympus-cluster.cluster-c9ltpnagyuxt.ap-south-1.rds.amazonaws.com:5432/cloudapi'
# alias lyft-prod-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:naW4GXjrmZ328Bf@us-west-2-rds-cluster-olympus.cluster-cq7fqrw6ubxv.us-west-2.rds.amazonaws.com:5432/cloudapi'
# alias lightyear-dev-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:66FeBcuHFvX4acT9@eu-central-1-rds-cluster.cluster-cohrmnxfrmlt.eu-central-1.rds.amazonaws.com:5432/cloudapi'
# alias jcb-dev-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:MAJLbvrX7fmpg4hm@us-west-2-rds-cluster.cluster-c0gcpiz6bgpx.us-west-2.rds.amazonaws.com:5432/cloudapi'
# alias proterra-dev-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:32bjH7dOgS3VlusZ@us-west-2-rds-cluster.cluster-cgkpne9hd04r.us-west-2.rds.amazonaws.com:5432/cloudapi'
# alias ktm-dev-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:Yk2Fr3zZk82TrsuK@us-west-2-rds-cluster.cluster-csxrawazdvuw.us-west-2.rds.amazonaws.com:5432/cloudapi'
# alias sibros-prod-us-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:TFHpbKWP5IHHLCfa@us-west-2-rds-cluster.cluster-comkhmwswyav.us-west-2.rds.amazonaws.com:5432/cloudapi'
# alias sibros-prod-eu-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:uh5vqHBj0d1we3Dx@eu-central-1-rds-cluster.cluster-cfrarngk4qvf.eu-central-1.rds.amazonaws.com:5432/cloudapi'
# alias sibros-dev-us-gcp-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:4gN7XLAcS6cobmE@10.168.0.11/cloudapi'
# alias sibros-staging-us-gcp-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:g1mNwI1gK7ES5xd@10.103.0.3/cloudapi'

# Kubernetes Pods - Timescale DB
# alias local-timescale-db='pgcli "postgres://timescale_user:timescale_password@localhost:5433/postgres?sslmode=disable"'
# alias sibros-dev-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:34HJjT9zxnN65h9@timescaledb-single.sibros-dbs.svc.cluster.local:5432/postgres'
# alias sibros-staging-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:FTjM04UwyFcp7lF@timescaledb-single.sibros-dbs.svc.cluster.local:5432/postgres'
# alias sibros-demo-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:22mQfbymLtDKyF3Z@timescaledb-single.sibros-dbs.svc.cluster.local:5432/postgres'
# alias bajaj-dev-timescale-db='kubectl run -i --tty pgsql-client --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:13mQfbymLtDKyF3U@timescaledb-single.sibros-dbs.svc.cluster.local:5432/postgres'
# alias bajaj-prod-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:D2cYe2Fq8yJ5oVn@timescaledb-single.sibros-dbs.svc.cluster.local:5432/postgres'
# alias lyft-prod-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:eeH9782Cyzet@timescaledb-single.sibros-dbs.svc.cluster.local:5432/timescaledb'
# alias lightyear-dev-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:DVqXwcB36EgVVubg@timescaledb-single.sibros-dbs.svc.cluster.local:5432/postgres'
# alias jcb-dev-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:C5vZjFgrhPsjmCCY@timescaledb-cluster.sibros-dbs.svc.cluster.local:5432/postgres'
# alias proterra-dev-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:4MWGl3jOuUNqaR63@timescaledb-cluster.sibros-dbs.svc.cluster.local:5432/postgres'
# alias ktm-dev-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:76IUfbymLtDKyHU7@timescaledb-single.sibros-dbs.svc.cluster.local:5432/postgres'

# Kubernetes Pods - Mobile DB
# alias local-mobile-db='pgcli "postgres://mobile_user:mobile_password@localhost:5434/mobiledb?sslmode=disable"'
# alias sibros-dev-mobile-db='kubectl run -i --tty mobile-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:y7cTYP72P5muZm2g@us-west-2-mobile-db-cluster.cluster-cmsezeuapyek.us-west-2.rds.amazonaws.com:5432/mobiledb'
# alias sibros-staging-mobile-db='kubectl run -i --tty mobile-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://postgres:Q2KU6Q3NLJ8xfRTM@us-west-2-mobile-db-cluster.cluster-cvwbr9hwsmni.us-west-2.rds.amazonaws.com:5432/mobiledb'
# alias bajaj-dev-mobile-db='kubectl run -i --tty mobile-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:13mQfbymLtDKyF3U@ap-south-1-rds-cluster-instance-0.cszdn7qvjkhc.ap-south-1.rds.amazonaws.com:5432/mobiledb'
# alias bajaj-prod-mobile-db='kubectl run -i --tty mobile-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:9AsVciR8PRUNe4x@ap-south-1-mobile-db-cluster.cluster-c9ltpnagyuxt.ap-south-1.rds.amazonaws.com:5432/mobiledb'

# Kubernetes Pods - Command DB
# alias local-command-db='pgcli "postgres://command_db_user:command_db_password@localhost:5435/commanddb?sslmode=disable"'
# alias sibros-dev-command-db='kubectl run -i --tty command-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://commanduser:5NPuLttYB3QvzJsG@us-west-2-rds-cluster.cluster-cmsezeuapyek.us-west-2.rds.amazonaws.com:5432/commanddb'
# alias sibros-staging-command-db='kubectl run -i --tty command-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://commanduser:7hWMwMyZS9bjhgJe@us-west-2-rds-cluster.cluster-cvwbr9hwsmni.us-west-2.rds.amazonaws.com:5432/commanddb'
# alias sibros-prod-eu-command-db='kubectl run -i --tty command-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://commanduser:55XYtn26vHw78Lg2@eu-central-1-command-rds-cluster.cluster-cfrarngk4qvf.eu-central-1.rds.amazonaws.com:5432/commanddb'
# alias sibros-dev-us-gcp-command-db='kubectl run -i --tty command-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://commanduser:sXl2aXSv5mQ5doC@10.168.0.11/commandapi'
# alias sibros-staging-us-gcp-command-db='kubectl run -i --tty command-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://commanduser:zm59hEmFhQk4D45@10.103.0.3/commandapi'
# alias sibros-preprod-ap-command-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://commanduser:8ON8CG4slP91Atm@ap-south-1-command-rds-cluster.cluster-ca8mjuqk0je9.ap-south-1.rds.amazonaws.com:5432/commanddb'

# Kubernetes Pods - Mahindra DB
# alias sibros-preprod-ap-mahindra-db='kubectl run -i --tty mahindra-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://mahindrauser:bc52sZoW3JY9CMu@ap-south-1-mahindra-rds-cluster.cluster-ca8mjuqk0je9.ap-south-1.rds.amazonaws.com:5432/mahindradb'

# Terraform Aliases
alias t='terraform'
alias ti='terraform init'
alias tiu='terraform init -upgrade'
alias tp='terraform plan'
alias tip='terraform init;terraform plan'
alias ta='terraform apply'
alias tia='terraform init;terraform apply'
alias tv='terraform validate'

# AWS Projects
# alias sibros-master='cd ~/Code/sibros/infrastructure/aws/sibros/master;export AWS_PROFILE=sibros-master;kubectl config unset current-context'
# alias sibros-logarchive='cd ~/Code/sibros/infrastructure/aws/sibros/logarchive;export AWS_PROFILE=sibros-logarchive;kubectl config unset current-context'
# alias sibros-audit='cd ~/Code/sibros/infrastructure/aws/sibros/audit;export AWS_PROFILE=sibros-audit;kubectl config unset current-context'
# alias sibros-infra='cd ~/Code/sibros/infrastructure/aws/sibros/infra;export AWS_PROFILE=sibros-infra;kc sibros-infra'
# alias sibros-interview='cd ~/Code/sibros/infrastructure/aws/sibros/interview;export AWS_PROFILE=sibros-interview;kubectl config unset current-context'

# alias sibros-dev='cd ~/Code/sibros/infrastructure/aws/sibros/dev;export AWS_PROFILE=sibros-dev;kc sibros-dev'
# alias sibros-dev-us-p='cd ~/Code/sibros/infrastructure/aws/sibros/dev-us-p;export AWS_PROFILE=sibros-dev-us-p;kubectl config unset current-context'
# alias sibros-staging='cd ~/Code/sibros/infrastructure/aws/sibros/staging;export AWS_PROFILE=sibros-staging;kc sibros-staging'
# alias sibros-staging-us-p='cd ~/Code/sibros/infrastructure/aws/sibros/staging-us-p;export AWS_PROFILE=sibros-staging-us-p;kubectl config unset current-context'
# alias sibros-demo='cd ~/Code/sibros/infrastructure/aws/sibros/demo;export AWS_PROFILE=sibros-demo;kc sibros-demo'
# alias sibros-preprod='cd ~/Code/sibros/infrastructure/aws/sibros/preprod;export AWS_PROFILE=sibros-preprod;kc sibros-preprod'
# alias sibros-preprod-eu='cd ~/Code/sibros/infrastructure/aws/sibros/preprod-eu;export AWS_PROFILE=sibros-preprod-eu;kc sibros-preprod-eu'
# alias sibros-preprod-eu-p='cd ~/Code/sibros/infrastructure/aws/sibros/preprod-eu-p;export AWS_PROFILE=sibros-preprod-eu-p;kubectl config unset current-context'
# alias sibros-preprod-ap='cd ~/Code/sibros/infrastructure/aws/sibros/preprod-ap;export AWS_PROFILE=sibros-preprod-ap;kc sibros-preprod-ap'

# alias sibros-prod-us='cd ~/Code/sibros/infrastructure/aws/sibros/prod-us;export AWS_PROFILE=sibros-prod-us;kc sibros-prod-us'
# alias sibros-prod-eu='cd ~/Code/sibros/infrastructure/aws/sibros/prod-eu;export AWS_PROFILE=sibros-prod-eu;kc sibros-prod-eu'

# alias bajaj-dev='cd ~/Code/sibros/infrastructure/aws/bajaj/dev;export AWS_PROFILE=bajaj-dev;kc bajaj-dev'
# alias bajaj-prod='cd ~/Code/sibros/infrastructure/aws/bajaj/prod;export AWS_PROFILE=bajaj-prod;kc bajaj-prod'

# alias lyft-prod='cd ~/Code/sibros/infrastructure/aws/lyft/prod;export AWS_PROFILE=lyft-prod;kc lyft-prod'
# alias lightyear-dev='cd ~/Code/sibros/infrastructure/aws/lightyear/dev;export AWS_PROFILE=lightyear-dev;kc lightyear-dev'
# alias harleydavidson-dev='cd ~/Code/sibros/infrastructure/aws/archived/harleydavidson/dev;export AWS_PROFILE=harleydavidson-dev;kubectl config unset current-context'
# alias jcb-dev='cd ~/Code/sibros/infrastructure/aws/jcb/dev;export AWS_PROFILE=jcb-dev;kc jcb-dev'
# alias proterra-dev='cd ~/Code/sibros/infrastructure/aws/proterra/dev;export AWS_PROFILE=proterra-dev;kc proterra-dev'
# alias ktm-dev='cd ~/Code/sibros/infrastructure/aws/ktm/dev;export AWS_PROFILE=ktm-dev;kc ktm-dev'
# alias ford-dev='cd ~/Code/sibros/infrastructure/aws/archived/ford/dev;export AWS_PROFILE=ford-dev;kubectl config unset current-context'

# alias engflow-prod='cd ~/Code/sibros/infrastructure/aws/vendors/engflow/prod;export AWS_PROFILE=engflow-prod;kubectl config unset current-context'

# GCP Projects
# alias sibros-dev-us-gcp='cd ~/Code/sibros/terraform-modules/gcp/sibros/dev/customer;gcloud config set project sibros-dev-us;kc sibros-dev-us-gcp'
# alias sibros-staging-us-gcp='cd ~/Code/sibros/terraform-modules/gcp/sibros/dev/customer;gcloud config set project sibros-staging-us;kc sibros-staging-us-gcp'
# alias sibros-preprod-eu-gcp='cd ~/Code/sibros/terraform-modules/gcp/sibros/dev/customer;gcloud config set project sibros-preprod-eu-375008'
# alias sibros-prod-eu-gcp='cd ~/Code/sibros/terraform-modules/gcp/sibros/dev/customer;gcloud config set project sibros-prod-eu;kc sibros-prod-eu-gcp'
# alias sibros-simulation-gcp='cd ~/Code/sibros/infrastructure;gcloud config set project sibros-simulation;kc sibros-simulation'
# alias sibros-master-gcp='cd ~/Code/sibros/terraform-modules/gcp/sibros/dev/sibros-master;gcloud config set project sibros-master;kubectl config unset current-context'

# Azure Projects
# alias azbajaj='cd ~/Code/sibros/infrastructure/azure/bajaj/dev;az account set -s 47d0c041-5d78-4c12-8f4e-2363f798e807;'
# alias azdev='cd ~/Code/sibros/infrastructure/azure/sibros/dev;az account set -s 9b72bbcd-7e7b-48b0-acda-14e60a9de11e;'

# Data Dog Projects
# export DD_HOST="https://api.datadoghq.com/"
# export DD_APP_KEY="b34261aa1480393c18f79ea2c2f10f3528154dbc"
# export DD_API_KEY="b9250049eae18dd49be5b452ca680c69"
# alias datadog='cd ~/Code/sibros/infrastructure/datadog;export AWS_PROFILE=sibros-infra;kubectl config unset current-context'

# Utility Softwares
alias top='htop'
alias du='ncdu --color dark -rr -x'
alias help='tldr'
alias ping='prettyping --nolegend'
alias flushdns='sudo killall -HUP mDNSResponder'
# alias proto='cd ~ && rm -rf ~/protodot/generated/*.* && \
# protodot -src ~/Code/sibros/interop/proto/sibros/deep_logger/live_logger.proto -output deep_logger && \
# protodot -src ~/Code/sibros/interop/proto/sibros/deep_updater/cloud.proto -output deep_updater && \
# protodot -src ~/Code/sibros/interop/proto/sibros/deep_updater/uptane.proto -output uptane && \
# protodot -src ~/Code/sibros/interop/proto/sibros/command_manager/command_manager.proto -output command_manager && \
# protodot -src ~/Code/sibros/interop/proto/sibros/command_manager/j1939/command_manager_j1939.proto -output command_manager_j1939 && \
# protodot -src ~/Code/sibros/interop/proto/sibros/command_manager/uds/command_manager_uds.proto -output command_manager_uds && \
# protodot -src ~/Code/sibros/interop/proto/sibros/command_manager/wifi/command_manager_wifi.proto -output command_manager_wifi && \
# protodot -src ~/Code/sibros/interop/proto/sibros/decoder_id_manager/decoder_id_manager.proto -output decoder_id_manager && \
# protodot -src ~/Code/sibros/interop/proto/sibros/device/device_info.proto -output device && \
# protodot -src ~/Code/sibros/interop/proto/customers/lyft/heartbeat.proto -output lyft && \
# protodot -src ~/go/src/gitlab.com/sibros/private/software/backend/services/serverless/proto/payload.proto -output data_streaming && \
# rm -rf ~/protodot/generated/*.dot && cd -'
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
# alias be='cd ~/go/src/gitlab.com/sibros/private/software/backend'
# alias infra='cd ~/Code/sibros/infrastructure'
alias dot='code ~/Code/personal/dotfiles'
alias miner='code ~/Code/personal/go-bitcoin-miner'
alias blog='code ~/Code/personal/english-blog.github.io'
alias tamil='code ~/Code/personal/tamil-blog.github.io'

# Photography aliases
alias cr2jpg='for infile in *.CR2; do convert $infile $(echo $infile|sed -n "s/CR2$/jpg/p"); done'

# Application aliases
# alias run='SERVICE_CONFIG_PATH=config/config.local.yaml SERVICE_SECRET_PATH=config/secret.local.yaml make run'

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
