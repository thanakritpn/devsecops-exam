# Multi-Environment Deployment Guide

This project supports deployment to multiple environments: **Development**, **UAT**, and **Production**.

## 🌍 Environments

### Development (dev)
- **Trigger**: Push to `develop` branch
- **Replicas**: 1
- **Resources**: Low (for testing)
- **Image Tag**: `develop`

### UAT (User Acceptance Testing)
- **Trigger**: Create tag `v*` (e.g., `v1.0.0`)
- **Replicas**: 2
- **Resources**: Medium
- **Image Tag**: Tag version

### Production (prd)
- **Trigger**: Push to `main` branch
- **Replicas**: 3
- **Resources**: High
- **Image Tag**: `latest`
- **Special**: Pod anti-affinity for high availability

## 🚀 Deployment Methods

### 1. Automatic Deployment

#### Deploy to Development
```bash
git checkout develop
git push origin develop
```

#### Deploy to UAT
```bash
git tag v1.0.0
git push origin v1.0.0
```

#### Deploy to Production
```bash
git checkout main
git push origin main
```

### 2. Manual Deployment (GitHub Actions)

1. Go to **Actions** tab in GitHub
2. Select **Multi-Environment Deployment**
3. Click **Run workflow**
4. Choose environment: `dev`, `uat`, or `prd`
5. Click **Run workflow**

## 📋 Environment Configuration

Each environment has its own configuration file:

- `environments/values-dev.yaml` - Development settings
- `environments/values-uat.yaml` - UAT settings
- `environments/values-prd.yaml` - Production settings

### Key Differences

| Setting | Dev | UAT | Prod |
|---------|-----|-----|------|
| Replicas | 1 | 2 | 3 |
| CPU Limit | 100m | 200m | 500m |
| Memory Limit | 64Mi | 128Mi | 256Mi |
| Pull Policy | Always | Always | IfNotPresent |
| Anti-Affinity | ❌ | ❌ | ✅ |

## 🔒 Security Scanning

All images are automatically scanned with **Trivy** for vulnerabilities:

- Scans run after image is built and pushed
- Results uploaded to GitHub Security tab
- Shows CRITICAL and HIGH severity vulnerabilities
- SARIF format for detailed analysis

## 📊 Viewing Scan Results

1. Go to **Security** tab in GitHub
2. Click **Code scanning**
3. View **Trivy** scan results
4. Check vulnerabilities by severity

## 🛠️ Local Testing

### Test Different Environments Locally

```bash
# Development
helm install ratings-dev onechart/onechart -f environments/values-dev.yaml

# UAT
helm install ratings-uat onechart/onechart -f environments/values-uat.yaml

# Production
helm install ratings-prd onechart/onechart -f environments/values-prd.yaml
```

### Upgrade Deployments

```bash
helm upgrade ratings-dev onechart/onechart -f environments/values-dev.yaml
```

### Check Deployment Status

```bash
kubectl get pods -l app.kubernetes.io/instance=ratings-dev
kubectl logs -l app.kubernetes.io/instance=ratings-dev
```

## 🔄 Workflow Diagram

```
Push to develop → Build develop tag → Deploy to DEV
        |
        ↓
Create tag v* → Build versioned tag → Deploy to UAT
        |
        ↓
Push to main → Build latest tag → Deploy to PROD
```

## ⚙️ Environment Variables

Each environment sets:
- `SERVICE_VERSION`: v1 (in-memory mode)
- `ENVIRONMENT`: development/uat/production

## 🎯 Best Practices

1. **Development**: Test all changes here first
2. **UAT**: Use for user acceptance testing with realistic data
3. **Production**: Deploy only after UAT approval
4. **Use tags**: Version your releases (v1.0.0, v1.1.0, etc.)
5. **Monitor**: Check logs and metrics after deployment

## 📝 Rollback

If deployment fails:

```bash
# List releases
helm list

# Rollback to previous version
helm rollback ratings-prd 1
```

## 🚨 Troubleshooting

### Deployment stuck in pending
```bash
kubectl describe pod <pod-name>
kubectl get events
```

### Image pull errors
- Check GHCR package visibility (should be Public)
- Verify image tag exists
- Check network connectivity

### Environment not deploying
- Verify branch/tag matches trigger conditions
- Check GitHub Actions logs
- Ensure environment is configured in GitHub Settings
