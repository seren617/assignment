# Introduction

This repository hosts a Python application built with Flask. 

The application is containerized using a multi-stage Dockerfile, which optimizes the build process by separating the build environment from the runtime environment. This approach reduces the final image size and ensures a cleaner, more efficient deployment.

The image is then pushed to Docker Hub. We deploy the application on Kubernetes, where it pulls the Docker image from Docker Hub and runs in the Kubernetes environment

## Getting Started 

To build and deploy the Docker image for the Python Flask application, follow these steps:

- Clone the repository: 
```bash
git clone https://github.com/seren617/assignment.git
```
- Navigate to the project directory:
```bash
cd assignment
```
- Build the Docker image:
```bash
docker build -t <name> .
```
- Tag the docker image for pushing it to your registry
```bash
docker tag <name> <registry/repo:tag>
```
- Push the Docker image to Docker Hub:
```bash
docker push <registry/repo:tag>
```
(Replace <name> with the desired name for your Docker image, and <registry/repo:tag> with your Docker registry and repository details.)

## Hosting the Application on Kubernetes

To deploy the Python Flask application on Kubernetes, follow these steps:

1. **Prepare the Kubernetes Manifest Files:**

   All Kubernetes manifest files are located in the `kubernetes` folder of this repository. These files define the necessary Kubernetes resources for your application.

2. **Apply the Manifest Files:**

   Copy the manifest files to your Kubernetes cluster environment. Apply the files in the following order to set up the application:

   ```bash
   kubectl apply -f kubernetes/namespace.yaml
   kubectl apply -f kubernetes/secret.yaml
   kubectl apply -f kubernetes/deployment.yaml
   kubectl apply -f kubernetes/service.yaml
   kubectl apply -f kubernetes/metrics-server.yaml
   kubectl apply -f kubernetes/hpa.yaml
   ```
3. **Access the Application:**

    After deploying, access your application as follows:

- Internally:

  Use the internal IP address:
  ```bash
  curl http://<internal-ip>:80
  ```
- Externally:

  Fetch the NodePort and use the external IP address:
  ```bash
  kubectl get svc -n <namespace> -o wide
  curl http://<external-ip>:<nodePort>
  ```
  Replace `internal-ip`, `external-ip`, and `nodePort` with the actual values from your Kubernetes setup.


