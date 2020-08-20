helm repo remove fluxcd 
kubectl delete ns fluxcd 

helm repo add fluxcd https://charts.fluxcd.io
kubectl create ns fluxcd
set MYUSERNAME "morbargig"
set MYREPONAME "echo-app-k8s-chart"
echo "git@github.com:$MYUSERNAME/$MYREPONAME"

helm upgrade -i flux fluxcd/flux --wait \
--namespace fluxcd \
--set git.url=git@github.com:$MYUSERNAME/$MYREPONAME

helm upgrade -i echo-app fluxcd/helm-operator --wait \
--namespace fluxcd \
--set git.ssh.secretName=flux-git-deploy \
--set helm.versions=v3

fluxctl identity --k8s-fwd-ns fluxcd

# fluxctl sync --k8s-fwd-ns fluxcd 

# followed by readme at https://github.com/morbargig/echo-app-k8s-chart
# get the ssh key add it to github 

