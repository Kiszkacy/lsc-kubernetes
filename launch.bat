minikube start
kubectl get nodes

helm repo add stable https://charts.helm.sh/stable
helm repo update
helm install nfs-provisioner stable/nfs-server-provisioner --set persistence.enabled=true --set persistence.size=5Gi --set storageClass.name=nfs-storage
	
kubectl apply -f pvc.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f job.yaml

minikube service web-server-service