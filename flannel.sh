images=(
    coreos/flannel:v0.11.0-amd64
    coreos/flannel:v0.11.0-arm
    coreos/flannel:v0.11.0-ppc64le
    coreos/flannel:v0.11.0-s390x
    kubernetes-ingress-controller/nginx-ingress-controller:0.24.1
)

for imageName in ${images[@]} ; do
    docker pull quay.azk8s.cn/$imageName
    docker tag quay.azk8s.cn/$imageName k8s.gcr.io/$imageName
    docker rmi quay.azk8s.cn/$imageName
done
