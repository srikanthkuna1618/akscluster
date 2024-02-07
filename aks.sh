#!/bin/bash

# Check if Azure CLI is already installed
if command -v az &> /dev/null; then
    echo "Azure CLI is already installed."
    exit 0
fi

# Add Microsoft signing key
curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor | \
    sudo tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null

# Add Azure CLI repository
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.list

# Update package index and install Azure CLI
sudo apt-get update
sudo apt-get install -y azure-cli

# Verify installation
if command -v az &> /dev/null; then
    echo "Azure CLI has been successfully installed."
else
    echo "Failed to install Azure CLI."
fi
git 

# Variables
RESOURCE_GROUP_NAME="myResourcegroup"
CLUSTER_NAME="myakscluster"
LOCATION="East US"
NODE_POOL1_NAME="nodepool1"
NODE_POOL2_NAME="nodepool2"
NODE_POOL1_SIZE="Standard_DS2_v2"   # Sample node size, change as needed
NODE_POOL2_SIZE="Standard_DS3_v2"   # Sample node size, change as needed
NODE_POOL1_MIN_NODES=1
NODE_POOL1_MAX_NODES=2
NODE_POOL2_MIN_NODES=1
NODE_POOL2_MAX_NODES=2

# Log in to Azure
az login

# Set the subscription
az account set --subscription "f7f1ad4b-cddb-4191-8a24-4b50fada8af9"

# Create a resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create AKS cluster with multiple node pools
az aks create \
    --resource-group $RESOURCE_GROUP_NAME \
    --name $CLUSTER_NAME \
    --node-count 3 \
    --enable-addons monitoring \
    --generate-ssh-keys \
    --nodepool-name $NODE_POOL1_NAME \
    --node-vm-size $NODE_POOL1_SIZE \
    --node-count $NODE_POOL1_MIN_NODES \
    --min-count $NODE_POOL1_MIN_NODES \
    --max-count $NODE_POOL1_MAX_NODES \
    --nodepool-name $NODE_POOL2_NAME \
    --node-vm-size $NODE_POOL2_SIZE \
    --node-count $NODE_POOL2_MIN_NODES \
    --min-count $NODE_POOL2_MIN_NODES \
    --max-count $NODE_POOL2_MAX_NODES
