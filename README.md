Hello-App GKE CI/CD Project

Overview
This is a "Hello, World" web application deployed to Google Kubernetes Engine with a fully automated CI/CD pipeline.

The project demonstrates:
    • Infrastructure as Code (IaC) with Terraform
    • Containerization with Docker
    • Kubernetes deployment management using Kustomize
    • Automated build, push, and deployment via GitHub Actions
    • Secrets management in Kubernetes
    • Publicly accessible application via Ingress + LoadBalancer

Architecture
GitHub Actions Pipeline
|
v
Docker Build & Push --> Artifact Registry
|
v
GKE Cluster (Kustomize applies Deployment, Service, Ingress)
|
v
Public URL via Ingress LoadBalancer
    • Docker image is pushed to GCP Artifact Registry
    • Kubernetes manifests are managed via Kustomize
    • Ingress exposes the application publicly
    • Secrets are injected as environment variables in the pods

Live Application
The deployed application is publicly accessible at:
[Hello App](http://34.102.210.94/)

Repository Structure
hello-gke-devops/
├─ .github/
│  └─ workflows/
│     └─ ci-cd.yml
├─ app/
│  ├─ Dockerfile
│  └─ index.html
├─ k8s/
│  ├─ deployment.yml
│  ├─ ingress.yml
│  ├─ kustomization.yml
│  ├─ namespace.yml
│  └─ service.yml
├─ terraform/
│  ├─ .terraform.lock.hcl
│  ├─ main.tf
│  ├─ providers.tf
│  └─ variables.tf                           
└─ README.md


Prerequisites
    • GitHub account
    • GCP account with Artifact Registry & GKE permissions
    • kubectl installed locally (for manual verification)
    • Terraform installed (optional)

Setup & Deployment
1. Clone the repository
git clone https://github.com/YOUR_GITHUB_USERNAME/hello-gke-devops.git
cd hello-gke-devops

2. Configure GitHub Secrets
Add the following repository secrets:
Secret Name	Description
GCP_PROJECT_ID	Your GCP project ID
GKE_CLUSTER	Name of the GKE cluster
GKE_ZONE	GKE cluster zone
GCP_SA_KEY	Service account JSON key with GKE & AR access
APP_CONFIG_KEY	Example secret for application configuration

3. CI/CD Pipeline
The GitHub Actions workflow (ci-cd-pipeline.yml) automatically:
    1. Checks out the repository
    2. Authenticates to GCP
    3. Builds the Docker image
    4. Pushes the image to Artifact Registry
    5. Applies Kubernetes manifests using Kustomize
    6. Injects secrets into the deployment
The workflow triggers automatically on push to the main branch.

4. Kubernetes Deployment (Manual Verification)
# Check pods
kubectl get pods -n hello-app
# Check services
kubectl get svc -n hello-app
# Check ingress
kubectl get ingress -n hello-app
    • The application should be available at the IP shown in the Ingress ADDRESS field.

Kustomize Configuration
k8s/kustomization.yml combines all Kubernetes manifests:
    • namespace.yml – Creates hello-app namespace
    • deployment.yml – Deploys the application with 2 replicas
    • service.yml – Exposes app internally
    • ingress.yml – Exposes app publicly via LoadBalancer
Environment variables from secrets are injected automatically.

Design Choices
    • Kustomize chosen for flexibility and future environment overlays
    • CI/CD via GitHub Actions for reproducibility and simplicity
    • GKE as a managed Kubernetes cluster for minimal operational overhead
    • Secrets managed securely via Kubernetes Secrets
    • Ingress with LoadBalancer exposes the app publicly
    • Docker optimized for small size and efficient deployment

Author
Varuna Priya – DevOps Engineer
