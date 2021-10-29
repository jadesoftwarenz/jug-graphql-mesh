# eksctl create cluster -f demo-cluster.yaml --install-vpc-controllers 

# create an ntfs storage class
kubectl apply -f .\ntfs-storage-class.yaml
kubectl apply -f .\ebs-windows-pvc.yaml

# deployments
kubectl apply -f .\demo-rap.yaml
kubectl apply -f .\demo-iis.yaml
kubectl apply -f .\demo-rest.yaml
