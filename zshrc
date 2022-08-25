# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# ZSH Prompt
source <(kubectl completion zsh)
source ~/Code/personal/kube-ps1/kube-ps1.sh

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats ' %s(%b)'
precmd () { vcs_info }
setopt prompt_subst

PROMPT='%F{41}%~%f ${vcs_info_msg_0_} $(kube_ps1) '

# ZSH Utilities
source ~/Library/Preferences/org.dystroy.broot/launcher/bash/br

# Go Path Variables (install from package, not using brew)
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# Rust Cargo Path Variables
export PATH=~/.cargo/bin:$PATH

# Python Poetry Path Variables
export PATH=~/.poetry/bin:$PATH

# Kubectl Krew Path Variables
export PATH=~/.krew/bin:$PATH

# Custom Software Path Variables
export PATH=~/Softwares:~/Softwares/google-cloud-sdk/bin:$PATH

# Local Path Variables
export PATH=/usr/local/opt/llvm@8/bin:/usr/local/opt/openjdk/bin:/usr/local/opt/ncurses/bin:/usr/local/opt/berkeley-db@4/bin:/usr/local/opt/sqlite/bin:/usr/local/opt/libxml2/bin:$PATH

# Gitlab CI config
export GITLAB_USER=smileprem@gitlab.com
export GITLAB_TOKEN=uFjtGau3GhzAFVy4s7py
export CI_JOB_TOKEN=uFjtGau3GhzAFVy4s7py

# Structurizr CLI
export WORKSPACE_ID=57915
export API_KEY=ee5e5955-ada9-4ab8-b477-1e1ef6267721
export API_SECRET=b4c24d81-035f-4086-a7c9-7f0814295239
export WORKSPACE_FILE=workspace.dsl

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
alias k8dash='kubectl port-forward service/k8dash 4654:4654 -n sibros-apps'

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
alias klms='kubectl logs -f deployments/metrics-server -n sibros-infra'
alias klmso='kubectl logs -f deployments/metrics-server -n kube-system'
alias klts0='kubectl logs -f timescaledb-single-0 -c timescaledb -n sibros-dbs'
alias klts1='kubectl logs -f timescaledb-single-1 -c timescaledb -n sibros-dbs'
alias klts2='kubectl logs -f timescaledb-single-2 -c timescaledb -n sibros-dbs'
alias kets0='kubectl exec -ti timescaledb-single-0  -n sibros-dbs -- /bin/bash'
alias kets1='kubectl exec -ti timescaledb-single-1  -n sibros-dbs -- /bin/bash'
alias kets2='kubectl exec -ti timescaledb-single-2  -n sibros-dbs -- /bin/bash'

# Kubernetes Infra Logs
alias kln='kubectl logs -f deployments/nginx-ingress-controller -n sibros-infra'
alias klnp='kubectl logs deployments/nginx-ingress-controller -n sibros-infra | jq -r ". | [(.timestamp),(.http.request.method),(.http.response.status_code),(.http.upstream.status_code),(.url.original)] | @csv" | column -t -s,'
alias klca='kubectl logs -f deployments/cluster-autoscaler -n kube-system'

# Kubernetes Pods - General
alias bb='kubectl run -i --tty busybox --image=yauritux/busybox-curl --restart=Never --rm -- sh'

# Kubernetes Pods - Olympus DB
alias local-olympus-db='pgcli "postgres://postgres_user:postgres_password@localhost:5432/olympus?sslmode=disable"'
alias sibros-dev-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:Cs6h2qwI6V4Ypfg@us-west-2-rds-cluster.cluster-cmsezeuapyek.us-west-2.rds.amazonaws.com:5432/cloudapi'
alias sibros-staging-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:knd958vXDPzUkLv@us-west-2-rds-cluster.cluster-cvwbr9hwsmni.us-west-2.rds.amazonaws.com:5432/cloudapi'
alias sibros-demo-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:LvV77YxRvHMBk9FG@us-west-2-rds-cluster.cluster-c6aj9ugrsy9v.us-west-2.rds.amazonaws.com:5432/cloudapi'
alias bajaj-dev-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:66FeBcuHFvX4acT9@ap-south-1-rds-cluster-instance-0.cszdn7qvjkhc.ap-south-1.rds.amazonaws.com:5432/cloudapi'
alias bajaj-prod-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:12Ykl8st8QVDK0J@ap-south-1-olympus-cluster.cluster-c9ltpnagyuxt.ap-south-1.rds.amazonaws.com:5432/cloudapi'
alias lyft-prod-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:naW4GXjrmZ328Bf@us-west-2-rds-cluster-olympus.cluster-cq7fqrw6ubxv.us-west-2.rds.amazonaws.com:5432/cloudapi'
alias lightyear-dev-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:66FeBcuHFvX4acT9@eu-central-1-rds-cluster.cluster-cohrmnxfrmlt.eu-central-1.rds.amazonaws.com:5432/cloudapi'
alias jcb-dev-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:MAJLbvrX7fmpg4hm@us-west-2-rds-cluster.cluster-c0gcpiz6bgpx.us-west-2.rds.amazonaws.com:5432/cloudapi'
alias proterra-dev-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:32bjH7dOgS3VlusZ@us-west-2-rds-cluster.cluster-cgkpne9hd04r.us-west-2.rds.amazonaws.com:5432/cloudapi'
alias ktm-dev-olympus-db='kubectl run -i --tty olympus-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://apiuser:Yk2Fr3zZk82TrsuK@us-west-2-rds-cluster.cluster-csxrawazdvuw.us-west-2.rds.amazonaws.com:5432/cloudapi'

alias sibros-prod-olympus-db='echo no olympus db for sibros prod'
alias harleydavidson-dev-olympus-db='echo no olympus db for harleydavidson dev'
alias ford-dev-olympus-db='echo no olympus db for ford dev'

# Kubernetes Pods - Timescale DB
alias local-timescale-db='pgcli "postgres://timescale_user:timescale_password@localhost:5433/postgres?sslmode=disable"'
alias sibros-dev-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:34HJjT9zxnN65h9@timescaledb-single.sibros-dbs.svc.cluster.local:5432/postgres'
alias sibros-staging-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:FTjM04UwyFcp7lF@timescaledb-single.sibros-dbs.svc.cluster.local:5432/postgres'
alias sibros-demo-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:22mQfbymLtDKyF3Z@timescaledb-single.sibros-dbs.svc.cluster.local:5432/postgres'
alias bajaj-dev-timescale-db='kubectl run -i --tty pgsql-client --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:13mQfbymLtDKyF3U@timescaledb-single.sibros-dbs.svc.cluster.local:5432/postgres'
alias bajaj-prod-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:D2cYe2Fq8yJ5oVn@timescaledb-single.sibros-dbs.svc.cluster.local:5432/postgres'
alias lyft-prod-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:eeH9782Cyzet@timescaledb-single.sibros-dbs.svc.cluster.local:5432/timescaledb'
alias lightyear-dev-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:DVqXwcB36EgVVubg@timescaledb-single.sibros-dbs.svc.cluster.local:5432/postgres'
alias jcb-dev-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:C5vZjFgrhPsjmCCY@timescaledb-cluster.sibros-dbs.svc.cluster.local:5432/postgres'
alias proterra-dev-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:4MWGl3jOuUNqaR63@timescaledb-cluster.sibros-dbs.svc.cluster.local:5432/postgres'
alias ktm-dev-timescale-db='kubectl run -i --tty timescale-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:76IUfbymLtDKyHU7@timescaledb-single.sibros-dbs.svc.cluster.local:5432/postgres'

alias sibros-prod-timescale-db='echo no timescale db for sibros prod'
alias harleydavidson-dev-timescale-db='echo no timescale db for harleydavidson dev'
alias ford-dev-timescale-db='echo no timescale db for ford dev'

# Kubernetes Pods - Mobile DB
alias local-mobile-db='pgcli "postgres://mobile_user:mobile_password@localhost:5434/mobiledb?sslmode=disable"'
alias sibros-dev-mobile-db='kubectl run -i --tty mobile-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:y7cTYP72P5muZm2g@us-west-2-mobile-db-cluster.cluster-cmsezeuapyek.us-west-2.rds.amazonaws.com:5432/mobiledb'
alias sibros-staging-mobile-db='kubectl run -i --tty mobile-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://postgres:Q2KU6Q3NLJ8xfRTM@us-west-2-mobile-db-cluster.cluster-cvwbr9hwsmni.us-west-2.rds.amazonaws.com:5432/mobiledb'
alias bajaj-dev-mobile-db='kubectl run -i --tty mobile-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:13mQfbymLtDKyF3U@ap-south-1-rds-cluster-instance-0.cszdn7qvjkhc.ap-south-1.rds.amazonaws.com:5432/mobiledb'
alias bajaj-prod-mobile-db='kubectl run -i --tty mobile-db-client-$USER --image=pygmy/pgcli --restart=Never --rm -- postgresql://hasurauser:9AsVciR8PRUNe4x@ap-south-1-mobile-db-cluster.cluster-c9ltpnagyuxt.ap-south-1.rds.amazonaws.com:5432/mobiledb'
alias sibros-demo-mobile-db='echo no mobile db for sibros demo'
alias lyft-prod-mobile-db='echo no mobile db for lyft prod'
alias lightyear-dev-mobile-db='echo no mobile db for lightyear-dev'
alias jcb-dev-mobile-db='echo no mobile db for jcb-dev'
alias proterra-dev-mobile-db='echo no mobile db for proterra-dev'
alias ktm-dev-mobile-db='echo no mobile db for ktm-dev'

alias sibros-prod-mobile-db='echo no mobile db for sibros prod'
alias harleydavidson-dev-mobile-db='echo no mobile db for harleydavidson-dev'
alias ford-dev-mobile-db='echo no mobile db for ford-dev'

# Terraform Aliases
export GODEBUG=asyncpreemptoff=1
alias t='terraform'
alias ti='terraform init'
alias tiu='terraform init -upgrade'
alias tp='terraform plan'
alias tip='terraform init;terraform plan'
alias ta='terraform apply'
alias tia='terraform init;terraform apply'
alias tv='terraform validate'

# AWS Projects
alias sibros-master='cd ~/Code/sibros/infrastructure/aws/sibros/master;export AWS_PROFILE=sibros-master;kubectl config unset current-context'
alias sibros-logarchive='cd ~/Code/sibros/infrastructure/aws/sibros/logarchive;export AWS_PROFILE=sibros-logarchive;kubectl config unset current-context'
alias sibros-audit='cd ~/Code/sibros/infrastructure/aws/sibros/audit;export AWS_PROFILE=sibros-audit;kubectl config unset current-context'
alias sibros-infra='cd ~/Code/sibros/infrastructure/aws/sibros/infra;export AWS_PROFILE=sibros-infra;kc sibros-infra'
alias sibros-interview='cd ~/Code/sibros/infrastructure/aws/sibros/interview;export AWS_PROFILE=sibros-interview;kubectl config unset current-context'

alias sibros-dev='cd ~/Code/sibros/infrastructure/aws/sibros/dev;export AWS_PROFILE=sibros-dev;kc sibros-dev'
alias sibros-staging='cd ~/Code/sibros/infrastructure/aws/sibros/staging;export AWS_PROFILE=sibros-staging;kc sibros-staging'
alias sibros-prod='cd ~/Code/sibros/infrastructure/aws/archived/sibros/prod;export AWS_PROFILE=sibros-prod;kubectl config unset current-context'
alias sibros-demo='cd ~/Code/sibros/infrastructure/aws/sibros/demo;export AWS_PROFILE=sibros-demo;kc sibros-demo'

alias bajaj-dev='cd ~/Code/sibros/infrastructure/aws/bajaj/dev;export AWS_PROFILE=bajaj-dev;kc bajaj-dev'
alias bajaj-prod='cd ~/Code/sibros/infrastructure/aws/bajaj/prod;export AWS_PROFILE=bajaj-prod;kc bajaj-prod'

alias lyft-prod='cd ~/Code/sibros/infrastructure/aws/lyft/prod;export AWS_PROFILE=lyft-prod;kc lyft-prod'
alias lightyear-dev='cd ~/Code/sibros/infrastructure/aws/lightyear/dev;export AWS_PROFILE=lightyear-dev;kc lightyear-dev'
alias harleydavidson-dev='cd ~/Code/sibros/infrastructure/aws/archived/harleydavidson/dev;export AWS_PROFILE=harleydavidson-dev;kubectl config unset current-context'
alias jcb-dev='cd ~/Code/sibros/infrastructure/aws/jcb/dev;export AWS_PROFILE=jcb-dev;kc jcb-dev'
alias proterra-dev='cd ~/Code/sibros/infrastructure/aws/proterra/dev;export AWS_PROFILE=proterra-dev;kc proterra-dev'
alias ktm-dev='cd ~/Code/sibros/infrastructure/aws/ktm/dev;export AWS_PROFILE=ktm-dev;kc ktm-dev'
alias ford-dev='cd ~/Code/sibros/infrastructure/aws/archived/ford/dev;export AWS_PROFILE=ford-dev;kubectl config unset current-context'

alias engflow-prod='cd ~/Code/sibros/infrastructure/aws/vendors/engflow/prod;export AWS_PROFILE=engflow-prod;kubectl config unset current-context'

# GCP Projects
alias ford-dev-gcp='cd ~/Code/sibros/infrastructure/gcp/ford/dev;gcloud config set project ford-dev-329523;kc ford-dev-gcp'
alias sibros-staging-gcp='cd ~/Code/sibros/infrastructure/gcp/sibros/staging;gcloud config set project sibros-staging-259522;kubectl config unset current-context'
alias sibros-simulation-gcp='cd ~/Code/sibros/infrastructure;gcloud config set project sibros-simulation;kc sibros-simulation'

# Azure Projects
alias azbajaj='cd ~/Code/sibros/infrastructure/azure/bajaj/dev;az account set -s 47d0c041-5d78-4c12-8f4e-2363f798e807;'
alias azdev='cd ~/Code/sibros/infrastructure/azure/sibros/dev;az account set -s 9b72bbcd-7e7b-48b0-acda-14e60a9de11e;'

# Data Dog Projects
export DD_HOST="https://api.datadoghq.com/"
export DD_APP_KEY="b34261aa1480393c18f79ea2c2f10f3528154dbc"
export DD_API_KEY="b9250049eae18dd49be5b452ca680c69"
alias datadog='cd ~/Code/sibros/infrastructure/datadog;export AWS_PROFILE=sibros-infra;kubectl config unset current-context'

# Utility Softwares
alias top='htop'
alias du='ncdu --color dark -rr -x'
alias help='tldr'
alias ping='prettyping --nolegend'
alias flushdns='sudo killall -HUP mDNSResponder'
alias proto='cd ~ && rm -rf ~/protodot/generated/*.* && \
protodot -src ~/Code/sibros/interop/proto/sibros/deep_logger/live_logger.proto -output deep_logger && \
protodot -src ~/Code/sibros/interop/proto/sibros/deep_updater/cloud.proto -output deep_updater && \
protodot -src ~/Code/sibros/interop/proto/sibros/deep_updater/uptane.proto -output uptane && \
protodot -src ~/Code/sibros/interop/proto/sibros/command_manager/command_manager.proto -output command_manager && \
protodot -src ~/Code/sibros/interop/proto/sibros/command_manager/j1939/command_manager_j1939.proto -output command_manager_j1939 && \
protodot -src ~/Code/sibros/interop/proto/sibros/command_manager/uds/command_manager_uds.proto -output command_manager_uds && \
protodot -src ~/Code/sibros/interop/proto/sibros/command_manager/wifi/command_manager_wifi.proto -output command_manager_wifi && \
protodot -src ~/Code/sibros/interop/proto/sibros/decoder_id_manager/decoder_id_manager.proto -output decoder_id_manager && \
protodot -src ~/Code/sibros/interop/proto/sibros/device/device_info.proto -output device && \
protodot -src ~/Code/sibros/interop/proto/customers/lyft/heartbeat.proto -output lyft && \
protodot -src ~/go/src/gitlab.com/sibros/cloud/backend/services/serverless/proto/payload.proto -output data_streaming && \
rm -rf ~/protodot/generated/*.dot && cd -'
alias profile='code ~/.zshrc'
alias reload='source ~/.zshrc'
alias chrome='open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security'

# Python aliases
alias python=/usr/local/bin/python3
alias pip=/usr/local/bin/pip3
export PYTHONPATH="~/Code/sibros/odxtools:$PYTHONPATH"

# Git aliases
alias gcm='git checkout master; git pull'

# Directory aliases
alias fe='cd ~/Code/sibros/frontend'
alias be='cd ~/go/src/gitlab.com/sibros/cloud/backend'
alias infra='cd ~/Code/sibros/infrastructure'
alias not='cd ~/go/src/gitlab.com/sibros/cloud/notary'
alias plat='cd ~/Code/sibros/platform'
alias cred='cd ~/Documents/Sibros/Credentials'

# Bitcoin aliases
alias btc='bitcoind -disablewallet -datadir=/Users/smileprem/Bitcoin/FullNode'

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
