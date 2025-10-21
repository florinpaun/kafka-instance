# Apache Kafka Docker Setup

A Docker Compose setup for running Apache Kafka with Zookeeper and Kafka UI, deployed on AWS EC2 with easy-to-use Makefile commands.

## Prerequisites

- Docker and Docker Compose installed
- Make utility installed
- AWS EC2 instance (if deploying to cloud)
- Ports 2181, 8080, 9092 open in security groups (for external access)

## Start kafka services

### 1. Configure Environment Variables

Create a `.env` file in the project root (see .env.example):

```bash
KAFKA_HOST=          
NODE_ENV=
KAFKA_HOST_EXTERNAL=
```

### 2. Start/Stop services

```bash
# Build and start all services
make start

# Stop all services
make stop
```

### 3. Verify Installation

Access Kafka UI at: `http://KAFKA_HOST:8080`

## Makefile Commands

### Environment Management

| Command | Description |
|---------|-------------|
| `make build` | Build and start Docker containers |
| `make start` | Alias for build |
| `make stop` | Stop and remove all containers |

### Topic Management

| Command | Description | Example |
|---------|-------------|---------|
| `make add-topic topic-name=<name>` | Create a new Kafka topic | `make add-topic topic-name=orders` |
| `make delete-topic topic-name=<name>` | Delete a Kafka topic | `make delete-topic topic-name=orders` |

## Environment Configuration

The Makefile uses `NODE_ENV` to determine the bootstrap server:

- **development && production**: (`<KAFKA_HOST>:9091/<KAFKA_HOST>:29092`) (see .env.example)

## AWS EC2 Security Group Configuration

Ensure these ports are open:

| Port | Service | Access |
|------|---------|--------|
| 2181 | Zookeeper | Optional (internal use) |
| 8080 | Kafka UI | Required for web access |
| 9092 | Kafka | Required for external clients |
