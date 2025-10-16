# DevSecOps Engineer Skill Assessment: The Ratings Service Deployment

## Project Overview

This project demonstrates the containerization and deployment of a microservice (ratings service) to Kubernetes following DevSecOps best practices.

## Completed Tasks

### ✅ Core Requirements

1. **Environment Setup**: Kind cluster configuration ready
2. **Source Code**: Ratings service from bookinfo project
3. **Containerization**: Dockerfile created and tested
4. **Local Development Setup**: docker-compose.yml for local testing
5. **Container Registry**: GitHub Actions workflow for GHCR
6. **Deployment**: Helm values.yaml for opsta/onechart

### ✅ Optional Tasks Completed

- ✅ **CI/CD Automation**: GitHub Actions workflow with build and push
- ✅ **Unit Testing**: Jest tests integrated in CI pipeline with test reports

## Quick Start

### Prerequisites

- Docker Desktop
- Node.js 14
- kubectl
- Helm 3
- kind

## Local Development

### 1. Install dependencies

```bash
npm install
```

### 2. Run locally with Node.js

```bash
npm start
# Access: http://localhost:8080
```

### 3. Run with Docker Compose

```bash
docker-compose up -d
# Test: curl http://localhost:8080/health
docker-compose down
```

### 4. Build Docker image manually

```bash
docker build -t ratings:latest .
docker run -p 8080:8080 -e SERVICE_VERSION=v1 ratings:latest
```

## Kubernetes Deployment

See detailed instructions in [KUBERNETES_SETUP.md](KUBERNETES_SETUP.md)

### Quick Deploy

```bash
# Create kind cluster
kind create cluster --name ratings-cluster

# Create GHCR secret
kubectl create secret docker-registry ghcr-secret \
  --docker-server=ghcr.io \
  --docker-username=YOUR_GITHUB_USERNAME \
  --docker-password=YOUR_GITHUB_TOKEN

# Add Helm repo
helm repo add onechart https://chart.onechart.dev
helm repo update

# Deploy
helm install ratings onechart/onechart -f values.yaml

# Verify
kubectl get pods
kubectl port-forward svc/ratings 8080:8080
```

## CI/CD Pipeline

The project includes a GitHub Actions workflow that:

1. **On Push/PR**: Runs unit tests with Jest
2. **On Push to main**: 
   - Builds Docker image
   - Pushes to GitHub Container Registry (GHCR)
   - Tags with multiple formats (latest, sha, branch)

### GitHub Actions Setup

1. Fork/create your repository
2. Enable GitHub Actions
3. Push to main branch - workflow runs automatically
4. Image will be available at `ghcr.io/YOUR_USERNAME/ratings`

## Project Structure

```
devsecops-exam/
├── .github/
│   └── workflows/
│       └── build-and-push.yml    # CI/CD pipeline
├── databases/
│   ├── ratings_data.json
│   └── script.sh
├── .dockerignore
├── .gitignore
├── docker-compose.yml            # Local development
├── Dockerfile                    # Container image definition
├── KUBERNETES_SETUP.md          # Detailed K8s setup guide
├── package.json                  # Node.js dependencies
├── ratings.js                    # Main application
├── ratings.test.js              # Unit tests
├── README.md                     # This file
└── values.yaml                   # Helm chart values
```

## Testing

```bash
# Run unit tests
npm test

# Run tests with coverage
npm test -- --coverage
```

## Environment Variables

- `SERVICE_VERSION`: Set to `v1` for in-memory mode (no database required)
- `SERVICE_VERSION`: Set to `v2` for database mode (MongoDB/MySQL required)

## API Endpoints

- `GET /health` - Health check endpoint
- `GET /ratings/{productId}` - Get ratings for a product
- `POST /ratings/{productId}` - Add rating for a product (v1 only)

## Troubleshooting

### Docker build fails
- Check Node.js version in Dockerfile
- Verify all files are present

### Container won't start
- Check logs: `docker logs <container-id>`
- Verify SERVICE_VERSION is set correctly

### Kubernetes pods not starting
- Check image pull secret: `kubectl get secret ghcr-secret`
- Verify image name in values.yaml
- Check logs: `kubectl logs -l app=ratings`

## Contributing

This is an assessment project. Follow these best practices:
- Write clear commit messages
- Test locally before pushing
- Document any changes

## License

Apache License 2.0 (from original Istio bookinfo project)

---

## Assessment Notes

**Completed by**: [Your Name]  
**Date**: October 2025  
**Optional Tasks**: CI/CD Automation, Unit Testing

For questions during the interview, I can explain:
- Design decisions for the Dockerfile
- CI/CD pipeline choices
- Kubernetes deployment strategy
- Security considerations
