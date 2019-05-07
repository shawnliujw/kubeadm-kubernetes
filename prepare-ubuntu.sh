#!/usr/bin/env bash


echo "Install Docker"
apt-get update && apt install -y docker.io apt-transport-https curl&& systemctl enable docker


echo "Install kubeadm"
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF


apt-get update && apt-get install -y  kubeadm