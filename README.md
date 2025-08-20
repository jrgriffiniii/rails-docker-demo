# rails-docker-demo

Demonstration of a simple Ruby on Rails application running in Docker with PostgreSQL as the database.

## Getting started

### Building the Docker Image

```bash
docker compose build
```

### Deploying the Docker Image Locally

```bash
# This initializes the database for PostgreSQL
docker compose run --rm web rails db:create
docker compose up -d
```

## Using k8s (Kubernetes)

The following shall ensure that minikube is installed and running on your local machine, along with providing the dashboard URL:

```bash
brew install minikube
minikube start
minikube dashboard --url
```

### Loading the Docker Image into Minikube

```bash
minikube image load --pull=false rails-docker-demo-web:latest
minikube image ls
```

### Deploying the Application in k8s

```bash
kubectl create -f k8s/rails-deployment.yaml
kubectl expose -f k8s/rails-service.yaml
```
