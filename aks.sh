#!/bin/bash

# Update package index and install Azure CLI
sudo apt-get update
sudo apt-get install -y azure-cli

# Variables

# Log in to Azure
az login

# Set the subscription

# Create a resource group
az group create --name myResourceGroup --location East US

# Create AKS cluster with multiple node pools
az aks create --resource-group myResourceGroup --name myAKSCluster --enable-managed-identity --node-count 2 --generate-ssh-keys

sudo snap install kubectl --classic

kubectl version --short

kubectl get nodes