# kubeadm-kubernetes  
Use kubeadm setup kubernetes cluster and enable ingress-rbac, prometheus etc...  
Also check sample [spring boot kubernetes](https://github.com/shawnliujw/spring-boot-kubernetes) if you are interesting

## Setup Cluster 
* run `sh install.sh`

## Configure Kubectl remote access   
copy `$HOME/.kube/config` to your localhost and edith below section：
 
```javascript

apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server: https://ip_address:port

```

## Access Dashboard  

* Run `kubectl proxy`  
* access `http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/`  
use the token generated above to login  


## Serverless(Kubeless)  
[Click Here](https://github.com/shawnliujw/serverless-kubernetes-sample/blob/master/README.md) to check the samples  

## Monitor(Prometheus,Grafana,Alert)  

### Install 
`kubectl apply -f prometheus.yaml`
### Access  
* Prometheus  

`kubectl --namespace monitoring port-forward svc/prometheus-k8s 9090`  
Then access via `http://localhost:9090`

* Grafana

`kubectl --namespace monitoring port-forward svc/grafana 3000`  
Then access via http://localhost:3000 and use the default grafana user:password of `admin:admin`.

* Alert Manager

`kubectl --namespace monitoring port-forward svc/alertmanager-main 9093`  
Then access via    `http://localhost:9093`


See more [here](https://github.com/coreos/kube-prometheus)  

## Config Private Docker Registry  
* create secret  
```bash
kubectl create secret docker-registry-secret --dry-run=true $secret_name \
--docker-server=<DOCKER_REGISTRY_SERVER> \
--docker-username=<DOCKER_USER> \
--docker-password=<DOCKER_PASSWORD> \
--docker-email=<DOCKER_EMAIL>

```
* patch secret to default service account  
`kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "docker-registry-secret"}]}'`  
then all the pods created in current namespace will have follow content:  
```bash
spec:
  imagePullSecrets:
  - name: docker-registry-secret
```