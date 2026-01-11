Hello-App GKE CI/CD Project

Overview
This is a simple "Hello, World" web application deployed to Google Kubernetes Engine (GKE) with a fully automated CI/CD pipeline.

The project demonstrates:
•	Infrastructure as Code (IaC) using Terraform
•	Containerization with Docker
•	Kubernetes deployment management using Kustomize
•	Automated build, scan, push, and deployment using GitHub Actions
•	Container image vulnerability scanning using Trivy
•	Secure secrets management using Kubernetes Secrets
•	Publicly accessible application using Ingress + LoadBalancer
________________________________________
Architecture

GitHub Actions CI/CD Pipeline
↓
Docker Build
↓
Trivy Vulnerability Scan
↓
Docker Push → GCP Artifact Registry
↓
GKE Cluster (Kustomize applies Kubernetes manifests)
↓
Public URL exposed via Ingress LoadBalancer
Key points:
•	Docker image is built and scanned before being pushed
•	Trivy scans the image for known vulnerabilities
•	Kubernetes manifests are managed using Kustomize
•	Ingress exposes the application publicly
•	Secrets are injected into pods as environment variables
________________________________________
Live Application

The deployed application is publicly accessible at:
http://34.102.210.94/
________________________________________
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
________________________________________
Prerequisites

•	GitHub account
•	GCP account with permissions for GKE and Artifact Registry
•	kubectl installed locally (for verification)
•	Terraform installed
________________________________________
Setup & Deployment

1. Clone the Repository
git clone https://github.com/YOUR_GITHUB_USERNAME/hello-gke-devops.git
cd hello-gke-devops
________________________________________
2. Configure GitHub Secrets

Add the following secrets in your GitHub repository:
•	GCP_PROJECT_ID – Your GCP project ID
•	GKE_CLUSTER – Name of the GKE cluster
•	GKE_ZONE – GKE cluster zone
•	GCP_SA_KEY – Service account JSON key with GKE and Artifact Registry access
•	APP_CONFIG_KEY – Example application secret
________________________________________
CI/CD Pipeline

The GitHub Actions workflow (ci-cd.yml) automatically performs the following steps on every push to the main branch:
1.	Checks out the source code
2.	Authenticates to Google Cloud
3.	Builds the Docker image
4.	Runs Trivy vulnerability scanning on the Docker image
5.	Fails the pipeline if HIGH or CRITICAL vulnerabilities are found
6.	Pushes the image to GCP Artifact Registry
7.	Applies Kubernetes manifests using Kustomize
8.	Deploys the application to GKE
This ensures only secure and verified images are deployed.
________________________________________
Security: Trivy Vulnerability Scanning

This project integrates Trivy into the CI/CD pipeline for container security.
Trivy scans:
•	OS-level packages
•	Application dependencies
•	Known CVEs with severity levels
Security benefits:
•	Prevents vulnerable images from reaching production
•	Implements DevSecOps best practices
•	Improves overall application security posture
Scan results are visible in GitHub Actions logs.
________________________________________
Kubernetes Deployment (Manual Verification)

To verify the deployment manually:
kubectl get pods -n hello-app
kubectl get svc -n hello-app
kubectl get ingress -n hello-app
The application will be available at the IP shown in the Ingress ADDRESS field.
________________________________________
Kustomize Configuration

The k8s/kustomization.yml file combines all Kubernetes resources:
•	namespace.yml – Creates the hello-app namespace
•	deployment.yml – Deploys the application with 2 replicas
•	service.yml – Exposes the application internally
•	ingress.yml – Exposes the application publicly via LoadBalancer
Environment variables are injected from Kubernetes Secrets.
________________________________________
Design Choices

•	Kustomize for flexible and environment-ready Kubernetes configuration
•	GitHub Actions for simple and reproducible CI/CD
•	GKE as a managed Kubernetes service
•	Trivy for container vulnerability scanning
•	Kubernetes Secrets for secure configuration
•	Ingress + LoadBalancer for public access
•	Lightweight Docker image for faster builds and deployments
________________________________________

