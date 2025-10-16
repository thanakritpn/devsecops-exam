# Kubernetes Setup Guide for Ratings Service

## Prerequisites

- Docker Desktop installed and running
- kubectl installed
- Helm 3 installed
- kind installed

## Step 1: Install kind (Kubernetes in Docker)

### Windows (PowerShell):
```powershell
# Using Chocolatey
choco install kind

# Or download binary
curl.exe -Lo kind-windows-amd64.exe https://kind.sigs.k8s.io/dl/v0.20.0/kind-windows-amd64
Move-Item .\kind-windows-amd64.exe C:\Windows\System32\kind.exe
```

### Verify installation:
```bash
kind version
```

## Step 2: Create kind cluster

```bash
kind create cluster --name ratings-cluster
```

## Step 3: Verify cluster

```bash
kubectl cluster-info --context kind-ratings-cluster
kubectl get nodes
```

## Step 4: Create GitHub Container Registry Secret

Replace `YOUR_GITHUB_USERNAME` and `YOUR_GITHUB_TOKEN` with your actual credentials:

```bash
kubectl create secret docker-registry ghcr-secret \
  --docker-server=ghcr.io \
  --docker-username=YOUR_GITHUB_USERNAME \
  --docker-password=YOUR_GITHUB_TOKEN \
  --docker-email=YOUR_EMAIL
```

### To generate GitHub Personal Access Token:
1. Go to GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Generate new token with `write:packages` and `read:packages` permissions
3. Copy the token (you won't see it again!)

## Step 5: Add opsta/onechart Helm repository

```bash
helm repo add onechart https://chart.onechart.dev
helm repo update
```

## Step 6: Deploy ratings service

```bash
helm install ratings onechart/onechart -f values.yaml
```

## Step 7: Verify deployment

```bash
kubectl get pods
kubectl get services
kubectl logs -l app=ratings
```

## Step 8: Test the service (from within cluster)

```bash
# Port forward to access locally
kubectl port-forward svc/ratings 8080:8080

# In another terminal, test the endpoint
curl http://localhost:8080/health
```

## Cleanup

```bash
# Delete Helm release
helm uninstall ratings

# Delete kind cluster
kind delete cluster --name ratings-cluster
```

## Troubleshooting

### If pods are in ImagePullBackOff:
1. Check if secret exists: `kubectl get secrets`
2. Verify secret is correct: `kubectl get secret ghcr-secret -o yaml`
3. Check image name in values.yaml matches your GHCR repository

### If pods are CrashLoopBackOff:
1. Check logs: `kubectl logs -l app=ratings`
2. Verify environment variables in values.yaml

### To delete and recreate secret:
```bash
kubectl delete secret ghcr-secret
kubectl create secret docker-registry ghcr-secret \
  --docker-server=ghcr.io \
  --docker-username=YOUR_GITHUB_USERNAME \
  --docker-password=YOUR_GITHUB_TOKEN \
  --docker-email=YOUR_EMAIL
```
