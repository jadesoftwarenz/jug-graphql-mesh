
# queries
kubectl get nodes
kubectl get pods -n kube-system
kubectl get service
kubectl get pods
kubectl get svc -o wide

kubectl delete -f .\demo-rap.yaml
kubectl delete -f .\demo-iis.yaml
kubectl delete -f .\demo-rest.yaml
