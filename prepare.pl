#!/usr/bin/env perl

die "kubeadm is not found" if system("which kubeadm");
our $MIRROR_PREFIX = "registry.cn-hangzhou.aliyuncs.com/google_containers";

for(`kubeadm config images list 2>/dev/null`){
	chomp;
	next unless /^([^\/]+)\/([^\/]+)$/;
	system("docker pull $MIRROR_PREFIX/$2");
	system("docker tag $MIRROR_PREFIX/$2 $1/$2");
}

