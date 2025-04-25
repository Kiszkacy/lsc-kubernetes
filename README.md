# Setup
Start the kubernetes cluster by running the ``launch.bat`` script. Make sure both Helm and Minikube are installed and properly configured beforehand.
```
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
```

## launch.bat explanation

### 1. ``minikube start``

Starts a local Kubernetes cluster using Minikube.

---

### 2. ``kubectl get nodes``

Verifies that the Kubernetes node is up and running.

---

### 3. ``helm repo add stable``

Adds the stable Helm chart repository.

---

### 4. ``helm repo update``

Refreshes the local Helm chart list to ensure the latest versions are available.

---

### 5. ``helm install nfs-provisioner stable/nfs-server-provisioner``

Installs the NFS server provisioner into your cluster using Helm.

  ``--set persistence.enabled=tru``
  Enables persistent storage
  
  ``--set persistence.size=5Gi``
  Allocates 5Gi of storage
  
  ``--set storageClass.name=nfs-storage``
  Sets the storageClass.name to nfs-storage, used later by your PVC

---

### 6. ``kubectl apply -f pvc.yaml``

Creates a PersistentVolumeClaim that binds to the NFS storage class provisioned earlier.

---

### 7. ``kubectl apply -f deployment.yaml``

Deploys an nginx web server with its content directory mounted to the PVC.

---

### 8. ``kubectl apply -f service.yaml``

Creates a service that exposes the nginx server to external access.

---

### 9. ``kubectl apply -f job.yaml``

Runs a one-time job that writes an HTML file into the NFS volume. This file will be served by Nginx.

---

### 10. ``minikube service web-server-service``

Opens the web service in your default browser by resolving the Minikube service URL.
