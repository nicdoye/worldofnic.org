
### I already have an external IP

### Compute Cluster

f1-micro requires 3 nodes

```bash
gcloud container clusters create worldofnic-production-cluster --num-nodes=3 --machine-type f1-micro --zone europe-west1-b
```

### app.yaml

```bash
kubectl create -f jekyll-www.worldofnic.org/conf/app.yaml
```

### Completely Dangerous Rollback

Only during initial deployment phase

```bash
kubectl delete replicationController worldofnic-rc
kubectl delete service worldofnic-svc
```

### Description

```bash
kubectl get svc worldofnic-svc
NAME             CLUSTER-IP     EXTERNAL-IP     PORT(S)          AGE
worldofnic-svc   10.3.251.146   146.148.26.37   80/TCP,443/TCP   9m
kubectl get svc kubernetes
NAME         CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   10.3.240.1   <none>        443/TCP   1h
kubectl get po
NAME                  READY     STATUS    RESTARTS   AGE
worldofnic-rc-2ivdl   1/1       Running   0          9m
worldofnic-rc-x5tav   1/1       Running   0          9m
worldofnic-rc-y44ak   1/1       Running   0          9m
kubectl get rc
NAME            DESIRED   CURRENT   AGE
worldofnic-rc   3         3         9m
kubectl get no
NAME                                                      STATUS    AGE
gke-worldofnic-production-cl-default-pool-cf9077b9-i2on   Ready     1h
gke-worldofnic-production-cl-default-pool-cf9077b9-vyu5   Ready     1h
gke-worldofnic-production-cl-default-pool-cf9077b9-z36r   Ready     1h
kubectl get ns
NAME          STATUS    AGE
default       Active    1h
kube-system   Active    1h
kubectl get ep
NAME             ENDPOINTS                                         AGE
kubernetes       130.211.89.196:443                                1h
worldofnic-svc   10.0.0.4:80,10.0.1.5:80,10.0.2.4:80 + 3 more...   11m
kubectl get cs
NAME                 STATUS    MESSAGE              ERROR
controller-manager   Healthy   ok
scheduler            Healthy   ok
etcd-0               Healthy   {"health": "true"}
etcd-1               Healthy   {"health": "true"}
```
## Updates

### Make changes

_open atom ... hack, hack, hack_

### Check in Jekyll

```bash
pushd files/www.worldofnic.org/
```
_etc._

### Build site

```bash
jekyll build
```
### Add changes into gitlab

```bash
git add .
git commit -m 'Updated footer'
git push
```
### Deal with Docker image

```bash
popd
docker build --tag=eu.gcr.io/worldofnic-production/worldofnic:v2.0.0 \ --tag=eu.gcr.io/worldofnic-production/worldofnic --no-cache --pull .
docker build --no-cache --pull jekyll-www.worldofnic.org
# test locally
docker run -d -p 8091:80 -p 8092:443 --name hugo eu.gcr.io/worldofnic-production/worldofnic
gcloud docker push eu.gcr.io/worldofnic-production/worldofnic:v2.0.0
gcloud docker push eu.gcr.io/worldofnic-production/worldofnic:latest
```

### Deploy

```bash
kubectl rolling-update frontend --image=eu.gcr.io/worldofnic-production/worldofnic-jekyll:v1.0.2
```

More complicated upgrades would involve creating a new YAML file like `rc-rollingupdate.yaml` with just the image in the RC.
