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

The following describes my attempts to get this running
https://stackoverflow.com/questions/57317501/kubernetes-modeling-jobs-cron-tasks-for-postgres-tomcat-application

```
kubectl apply -f dspace.deploy.v6.yaml
kubectl get pods -o wide
# pod names will vary
kubectl logs dspace-deploy-c59b77bb8-mr47k
winpty kubectl exec -it dspace-deploy-c59b77bb8-mr47k -- //bin/bash

kubectl get services -o wide
kubectl port-forward service/dspace-service 8080:8080

kubectl apply -f dpace.job.create-admin.yaml

kubectl get pods -o wide
kubectl delete -f dpace.job.create-admin.yaml

kubectl apply -f dpace.job.ingest.v6.yaml

kubectl delete -f dspace.deploy.v6.yaml
```

### TODOs
- figure out the best way to run create-administrator
- attempt to create a "job" that contains dspace CLI without running tomcat (or a separate image)
- fix hostname references

#### Local Volume Notes
- https://vocon-it.com/2018/12/20/kubernetes-local-persistent-volumes/
- https://stackoverflow.com/questions/57227990/kubernetes-in-docker-for-windows-volume-configuration-for-postgres
- https://learning.oreilly.com/library/view/kubernetes-cookbook/9781491979679/ch08.html#ch_volumes_config

#### Google Cloud

_Using lessons from Chapter 3 of Kubernetes Up and Running_
```
gcloud config set compute/zone us-west1-a
gcloud container clusters create --num-nodes 1 dspace-cluster
gcloud auth application-default login

kubectl apply -f dspace.deploy.v6.yaml
kubectl apply -f dspace.job.create-admin.yaml
kubectl apply -f dspace.job.ingest.v6.yaml

kubectl port-forward dspace-deploy... 8080:8080
# TODO: figure out how to expose a GKE service to the internet
# See https://cloud.google.com/kubernetes-engine/docs/how-to/exposing-apps

```

#### Delete

```
kubectl delete -f dspace.yaml
gcloud container clusters delete dspace-cluster
```
