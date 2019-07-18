#!/usr/bin/env bash


echo "Init Cluster"
swapoff /swapfile   && sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# use Flannel as pod network plugin
kubeadm init --pod-network-cidr=10.244.0.0/16  --image-repository gcr.akscn.io/google_containers

echo "Configure kubeconfig"
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config


echo "disable master node isolate"
kubectl taint nodes --all node-role.kubernetes.io/master-

echo "Install Network Plugin"
kubectl apply -f  https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

echo "Config Ingress"

kubectl apply -f https://raw.githubusercontent.com/shawnliujw/kubeadm-kubernetes/master/ingress.yaml

echo "Configure Dashboard"
kubectl apply -f https://raw.githubusercontent.com/shawnliujw/kubeadm-kubernetes/master/kubernetes-dashboard.yaml

kubectl apply -f https://raw.githubusercontent.com/shawnliujw/kubeadm-kubernetes/master/admin-role.yaml



echo "Print Access Token"

kubectl -n kube-system describe secret $(kubectl -n kube-system get secret|grep admin-token | awk '{print $1}')

echo "Done"
