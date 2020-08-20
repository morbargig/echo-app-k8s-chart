
# delete ngnix ingress
# helm uninstall ngnix
kubectl delete namespace cert-manager
kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.26.1/deploy/static/provider/cloud-generic.yaml
kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.26.1/deploy/static/mandatory.yaml
kubectl delete -f prod_issuer.yaml
# kubectl delete -f letsencrypt-staging.yaml 
kubectl delete -f https://github.com/jetstack/cert-manager/releases/download/v0.12.0/cert-manager.yaml
# sed -i 's/letsencrypt-prod/letsencrypt-staging/g' ingress-ngnix.yaml

# setup ingress setup
kubectl create namespace cert-manager
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v0.12.0/cert-manager.yaml
# helm install ngnix  --set controller.publishService.enabled=true   nginx-stable/nginx-ingress
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.26.1/deploy/static/mandatory.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.26.1/deploy/static/provider/cloud-generic.yaml

# get fake cartificate
# kubectl apply -f letsencrypt-staging.yaml 
# kubectl apply -f ingress-ngnix.yaml 
sleep 20
# get real cartificate
kubectl apply -f prod_issuer.yaml
# sed -i 's/letsencrypt-staging/letsencrypt-prod/g' ingress-ngnix.yaml
