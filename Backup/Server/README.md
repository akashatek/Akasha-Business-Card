# Server Setup

This directory contains the server configuration for Couchbase and Sync Gateway to enable data synchronization across platforms.

## Prerequisites

- Docker Desktop installed and running

## Starting the Services

1. Navigate to the Server directory:
   ```
   cd Server
   ```

2. Start Couchbase and Sync Gateway using Docker Compose:
   ```
   docker-compose up -d
   ```

3. Access Couchbase Web UI at http://localhost:8091 (admin/password)

4. Sync Gateway will be running on http://localhost:4984

## Stopping the Services

To stop the services:
```
docker-compose down
```

## Configuration

- `docker-compose.yaml`: Defines the Couchbase and Sync Gateway services
- `sync-gateway-config.json`: Configuration for Sync Gateway
