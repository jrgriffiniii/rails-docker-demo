# rails-docker-demo

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

