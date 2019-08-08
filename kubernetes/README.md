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
kubectl delete -f dspace.deploy.v6.yaml
kubectl delete -f dspace.job.create-admin.yaml
kubectl delete -f dspace.job.ingest.v6.yaml
gcloud container clusters delete dspace-cluster
```

#### Log

```
C:\Users\twb27\Documents\GitHub\DSpace-Docker-Images\kubernetes>gcloud container clusters create --num-nodes 1 dspace-cluster
WARNING: In June 2019, node auto-upgrade will be enabled by default for newly created clusters and node pools. To disable it, use the `--no-enable-autoupgrade` flag.
WARNING: Starting in 1.12, new clusters will have basic authentication disabled by default. Basic authentication can be enabled (or disabled) manually using the `--[no-]enable-basic-auth` flag.
WARNING: Starting in 1.12, new clusters will not have a client certificate issued. You can manually enable (or disable) the issuance of the client certificate using the `--[no-]issue-client-certificate` flag.
WARNING: Starting in 1.12, default node pools in new clusters will have their legacy Compute Engine instance metadata endpoints disabled by default. To create a cluster with legacy instance metadata endpoints disabled in the default node pool, run `clusters create` with the flag `--metadata disable-legacy-endpoints=true`.
WARNING: The Pod address range limits the maximum size of the cluster. Please refer to https://cloud.google.com/kubernetes-engine/docs/how-to/flexible-pod-cidr to learn how to optimize IP address allocation.
This will enable the autorepair feature for nodes. Please see https://cloud.google.com/kubernetes-engine/docs/node-auto-repair for more information on node autorepairs.
Creating cluster dspace-cluster in us-west1-a... Cluster is being health-checked (master is healthy)...done.
Created [https://container.googleapis.com/v1/projects/terry-1/zones/us-west1-a/clusters/dspace-cluster].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/us-west1-a/dspace-cluster?project=terry-1
kubeconfig entry generated for dspace-cluster.
NAME            LOCATION    MASTER_VERSION  MASTER_IP    MACHINE_TYPE   NODE_VERSION   NUM_NODES  STATUS
dspace-cluster  us-west1-a  1.12.8-gke.10   35.230.0.48  n1-standard-1  1.12.8-gke.10  1          RUNNING

C:\Users\twb27\Documents\GitHub\DSpace-Docker-Images\kubernetes>kubectl get pods
No resources found.

C:\Users\twb27\Documents\GitHub\DSpace-Docker-Images\kubernetes>kubectl apply -f dspace.deploy.v6.yaml
configmap "local-config-map" created
service "dspacedb-service" created
deployment.apps "dspacedb-deploy" created
service "dspace-service" created
deployment.apps "dspace-deploy" created

C:\Users\twb27\Documents\GitHub\DSpace-Docker-Images\kubernetes>kubectl get pods
NAME                               READY     STATUS              RESTARTS   AGE
dspace-deploy-57987ffff7-njf8l     0/1       ContainerCreating   0          7s
dspacedb-deploy-6dd7794dbb-bcrbm   0/1       ContainerCreating   0          7s

C:\Users\twb27\Documents\GitHub\DSpace-Docker-Images\kubernetes>kubectl get pods
NAME                               READY     STATUS              RESTARTS   AGE
dspace-deploy-57987ffff7-njf8l     0/1       ContainerCreating   0          10s
dspacedb-deploy-6dd7794dbb-bcrbm   0/1       ContainerCreating   0          10s

C:\Users\twb27\Documents\GitHub\DSpace-Docker-Images\kubernetes>kubectl get pods
NAME                               READY     STATUS              RESTARTS   AGE
dspace-deploy-57987ffff7-njf8l     0/1       ContainerCreating   0          14s
dspacedb-deploy-6dd7794dbb-bcrbm   0/1       ContainerCreating   0          14s

C:\Users\twb27\Documents\GitHub\DSpace-Docker-Images\kubernetes>kubectl get pods
NAME                               READY     STATUS    RESTARTS   AGE
dspace-deploy-57987ffff7-njf8l     1/1       Running   0          6m
dspacedb-deploy-6dd7794dbb-bcrbm   1/1       Running   0          6m

C:\Users\twb27\Documents\GitHub\DSpace-Docker-Images\kubernetes>kubectl port-forward dspace-pod 8080:8080
Error from server (NotFound): pods "dspace-pod" not found

C:\Users\twb27\Documents\GitHub\DSpace-Docker-Images\kubernetes>kubectl port-forward dspace-deploy-57987ffff7-njf8l 8080:8080
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080

C:\Users\twb27\Documents\GitHub\DSpace-Docker-Images\kubernetes>gcloud container clusters delete dspace-cluster
The following clusters will be deleted.
 - [dspace-cluster] in [us-west1-a]

Do you want to continue (Y/n)?  y

Deleting cluster dspace-cluster...done.
Deleted [https://container.googleapis.com/v1/projects/terry-1/zones/us-west1-a/clusters/dspace-cluster].

```

### AWS

- create cluster "dspace"
- install AWS kubectl
- aws eks --region region update-kubeconfig --name dspace
- try https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html

eksctl create cluster \
--name dspace \
--version 1.13 \
--nodegroup-name standard-workers \
--node-type t3.medium \
--nodes 1 \
--nodes-min 1 \
--nodes-max 1 \
--node-ami auto

#### Log
```
:/tmp $ eksctl create cluster --name dspace2 --version 1.13 --nodegroup-name standard-workers --node-type t3.medium --nodes 1 --nodes-min 1 --nodes-max 1 --node-ami auto   
[ℹ]  using region us-west-2
[ℹ]  setting availability zones to [us-west-2a us-west-2d us-west-2b]
[ℹ]  subnets for us-west-2a - public:192.168.0.0/19 private:192.168.96.0/19
[ℹ]  subnets for us-west-2d - public:192.168.32.0/19 private:192.168.128.0/19
[ℹ]  subnets for us-west-2b - public:192.168.64.0/19 private:192.168.160.0/19
[ℹ]  nodegroup "standard-workers" will use "ami-03a55127c613349a7" [AmazonLinux2/1.13]
[ℹ]  using Kubernetes version 1.13
[ℹ]  creating EKS cluster "dspace2" in "us-west-2" region
[ℹ]  will create 2 separate CloudFormation stacks for cluster itself and the initial nodegroup
[ℹ]  if you encounter any issues, check CloudFormation console or try 'eksctl utils describe-stacks --region=us-west-2 --name=dspace2'
[ℹ]  CloudWatch logging will not be enabled for cluster "dspace2" in "us-west-2"
[ℹ]  you can enable it with 'eksctl utils update-cluster-logging --region=us-west-2 --name=dspace2'
[ℹ]  2 sequential tasks: { create cluster control plane "dspace2", create nodegroup "standard-workers" }
[ℹ]  building cluster stack "eksctl-dspace2-cluster"
[ℹ]  deploying stack "eksctl-dspace2-cluster"
[ℹ]  building nodegroup stack "eksctl-dspace2-nodegroup-standard-workers"
[ℹ]  deploying stack "eksctl-dspace2-nodegroup-standard-workers"


[✔]  all EKS cluster resource for "dspace2" had been created
[✔]  saved kubeconfig as "/home/ec2-user/.kube/config"

```
