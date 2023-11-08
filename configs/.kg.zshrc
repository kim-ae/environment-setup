alias gcloud-kg-qa1="kubectl config use-context kg-qa1"
alias gcloud-kg-staging="kubectl config use-context kg-staging"
alias rabbit-kg="kubectl port-forward --namespace things svc/things-rabbitmq 15672:15672"
alias rabbit-bitb="kubectl port-forward --namespace bitb svc/rabbitmq 15672:15672"
alias mysql-things="kubectl port-forward --namespace infra svc/mysqlproxy-things 3307:3306"
alias mysql-shared="kubectl port-forward --namespace infra svc/mysqlproxy 3306:3306"
alias proxy-kg-prod='gcloud beta compute ssh --zone "europe-west3-b" "warehouse-m-2"  --tunnel-through-iap --project "kiwigrid-196414" -- -D 18010'
alias proxy-kg-staging='gcloud beta compute ssh --zone "europe-west3-b" "warehouse-m-2"  --tunnel-through-iap --project "kiwigrid-staging-220513" -- -D 18011'
alias repos="cd ~/Code"
copy-context() {
    cp ~/github/linux-setup/configs/.kg.p10k.zsh ~/.p10k.zsh
    cp ~/github/linux-setup/configs/kg.kube.config.yaml ~/.kube/config
}

update-context-files(){
    cp ~/.p10k.zsh ~/github/linux-setup/configs/.sas.p10k.zsh
    cp ~/.kube/config ~/github/linux-setup/configs/sas.kube.config.yaml
}