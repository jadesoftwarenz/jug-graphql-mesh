# create an EKS cluster containing a Windows and a Linux node group
eksctl create cluster -f demo-cluster.yaml --install-vpc-controllers 

# create an ntfs storage class
kubectl apply -f .\ntfs-storage-class.yaml
# create a persistent volume claim to host the JADE database
kubectl apply -f .\ebs-windows-pvc.yaml

# deploy database server (RAP), IIS and REST provider pods
kubectl apply -f .\demo-rap.yaml
kubectl apply -f .\demo-iis.yaml
kubectl apply -f .\demo-rest.yaml

## deprovision resources ##
# delete the jug-demo-cluster cluster 
# eksctl delete cluster jug-demo-cluster
