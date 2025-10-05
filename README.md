# DevSecOps Engineer Skill Assessment: The Ratings Service Deployment

## Introduction

Welcome! This assessment is designed to evaluate your research and development skills in a practical, hands-on scenario. We're more interested in your problem-solving approach, your ability to learn and apply new technologies, and your understanding of DevSecOps principles than in your memorization of specific commands.

Feel free to use any resources at your disposal, including official documentation, articles, and AI assistants.

---

## Objective

Your goal is to take a simple microservice, containerize it, secure its artifacts, and deploy it onto a local Kubernetes cluster following modern cloud-native practices.

---

## Scenario

You are a DevSecOps Engineer tasked with onboarding a new application, the `ratings` service, onto the company's standard Kubernetes platform. You must create a repeatable and automated process for building and deploying this service.

---

## Core Requirements

These tasks must be completed to be considered for the position.

1.  **Environment Setup**:
    * You can perform this assessment on your local machine, Google Cloud Shell, or any cloud-based virtual machine.
    * Set up a local Kubernetes cluster using **`kind`**.

2.  **Source Code**:
    * Create your own **public** GitHub repository for this project.
    * Clone the source code for the `ratings` service from [this repository](https://github.com/opsta/bookinfo/tree/main/src/ratings) into your project.

3.  **Containerization**:
    * Write your own `Dockerfile` to build a container image for the `ratings` service.
    * The service must be configured to run in a mode that **does not require a database**.
    * Build the image and ensure it runs correctly on your local Docker daemon before proceeding.

4.  **Local Development Setup**:
    * Create a **`docker-compose.yml`** file to run the `ratings` service locally. This is crucial for verifying your container setup and configuration before moving to Kubernetes.

5.  **Container Registry**:
    * Push your container image to the **GitHub Container Registry (GHCR)**.
    * The image repository must be **private**. You will need to figure out how to authenticate your Kubernetes cluster to pull from a private GHCR registry.

6.  **Deployment**:
    * Deploy the `ratings` service to your `kind` cluster using the [opsta/onechart](https://github.com/opsta/onechart) Helm chart. You will need to add the Helm repository and read its documentation to understand how to use it.
    * Create a `values.yaml` file within your repository to configure the deployment.
    * The application must be exposed within the cluster using only a **`ClusterIP`** service type.

---

## Optional (A Plus) Tasks

Completing any of the following tasks will significantly strengthen your assessment.

-   **Database Integration (MongoDB)**: Modify the application to connect to a MongoDB database. Add MongoDB to your `docker-compose.yml` for local development, and create a manifest or find a Helm chart to deploy it to Kubernetes.
-   **GitOps Deployment**: Deploy the application to your cluster using **ArgoCD**. The ArgoCD instance can run within the same `kind` cluster.
-   **CI/CD Automation**: Implement a **GitHub Actions** workflow that automatically:
    -   Builds the Docker image upon a push to the `main` branch.
    -   Pushes the new image to GHCR.
-   **Multi-Environment CI/CD**: Create a CI/CD pipeline that supports deploying to `dev`, `uat`, and `prd` environments (e.g., using different branches, tags, or manual triggers).
-   **Unit Testing**: Enhance the GitHub Actions pipeline to:
    -   Run the application's unit tests (`npm test`).
    -   Display the test report summary within the GitHub Actions UI.
-   **Ingress & SSL**: Expose the `ratings` service to the outside world using an Ingress controller (e.g., NGINX Ingress Controller) and secure it with a valid SSL certificate (e.g., using `cert-manager` with a self-signed issuer or Let's Encrypt).
-   **Code Scanning (SAST)**: Integrate **SonarQube** into your CI pipeline to scan the source code. Identify and fix at least one "Security Hotspot" found in the code. Document your findings and the fix.
-   **Image Scanning**: Integrate an image vulnerability scanner (e.g., Trivy, Grype) into your CI pipeline. Analyze the results and modify your `Dockerfile` to minimize the number of vulnerabilities.

---

## Deliverables

Please provide a single link to your public GitHub repository. The repository should contain:

1.  The complete source code for the `ratings` service.
2.  Your `Dockerfile`.
3.  Your `docker-compose.yml`.
4.  The Helm `values.yaml` file used for deployment.
5.  All GitHub Actions workflow files (`.github/workflows/`).
6.  An updated `README.md` explaining how to set up and run your project, and detailing which optional tasks you completed.

---

## ⭐ Important Note on AI Usage

You are encouraged to use AI assistants (like ChatGPT, Gemini, Copilot, etc.) to help you. However, you **must show all your processes while on interview**.

---

## Evaluation Criteria

You will be evaluated on:

* **Functionality**: Does the final deployment work as required?
* **Correctness**: Have you followed the instructions correctly?
* **Best Practices**: Your use of `.gitignore`, `.dockerignore`, commit message clarity, and the structure of your repository.
* **Code Quality**: The clarity, efficiency, and security of your `Dockerfile` and configuration files.
* **Problem-Solving**: The approach you took to research and implement solutions, especially for the optional tasks.

Good luck!
