## Running DSpace in Kubernetes

### Resources
- [Kuberenetes Up and Running](http://shop.oreilly.com/product/0636920043874.do)

### Options for running Kubernetes
- Kubernetes bundled with Docker Desktop
  - Enable kubernetes in Docker Desktop
  - Use kubectl in Docker Desktop
- Minikube
  - https://kubernetes.io/docs/tasks/tools/install-minikube/
- Google Cloud
  - https://cloud.google.com/kubernetes-engine/docs/quickstart
  - This has been the most reliable option for me so far, but it does have a cost.

### Recipes

#### Docker Desktop

```
kubectl apply -f dspace.k8.yaml
kubectl get pods
kubectl logs dspace-pod -c dspace
winpty kubectl exec -it dspace-pod -c dspace -- //bin/bash
kubectl port-forward dspace-pod 8080:8080
kubectl delete -f dspace.k8.yaml
```

#### Local Volume Notes
- https://vocon-it.com/2018/12/20/kubernetes-local-persistent-volumes/
- https://stackoverflow.com/questions/57227990/kubernetes-in-docker-for-windows-volume-configuration-for-postgres
- https://learning.oreilly.com/library/view/kubernetes-cookbook/9781491979679/ch08.html#ch_volumes_config

#### Google Cloud

_Using lessons from Chapter 3 of Kubernetes Up and Running_
```
gcloud config set compute/zone us-west1-a
gcloud container clusters create dspace-cluster
gcloud auth application-default login

kubectl apply -f dspace.yaml
kubectl port-forward dspace-pod 8080:8080
```

#### Delete

```
kubectl delete -f dspace.yaml
gcloud container clusters delete kuar-cluster
```
