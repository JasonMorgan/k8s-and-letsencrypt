#!/bin/bash

## Using helm with RBAC enabled k8s

vim tiller.yml

echo "helm init --service-account tiller"

### If it's already in place you need to add the upgrade switch

helm init --service-account tiller --upgrade

## Install cert-manager

helm install stable/cert-manager

### wait for cert-manager to be ready

helm ls

## Set up issuer

vim issuer.yml

kubectl apply -f issuer.yml

## Set up our AWS Credentials secret

vim route53-credentials-secret.yml

kubectl apply -f route53-credentials-secret.yml

## Set up requester

vim requester.yml

kubectl apply -f requester.yml

## Watch the request

kubens kube-system
kubectl get pods
kubectl logs cert-manager-cert-manager-698758c6d-7dgfh
kubens tools
kubectl get certificate
kubectl describe certificate 59s-io

### Checkout the cert

kubectl get secret 59s-io-tls -o yaml

echo <paste in the crt> | base64 -D

## Set up our ingress controller

helm install stable/nginx-ingress

### Set up an ingress rule

vim ingress-rule.yml

kubectl apply -f ingress-rule.yml

