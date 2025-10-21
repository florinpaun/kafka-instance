# Apache Kafka Docker Setup

A Docker Compose setup for running Apache Kafka with Zookeeper and Kafka UI, deployed on AWS EC2 with easy-to-use Makefile commands.

## Prerequisites

- Docker and Docker Compose installed
- Make utility installed
- AWS EC2 instance (if deploying to cloud)
- Ports 2181, 8080, 9092 open in security groups (for external access)

## Start kafka services

### 1. Configure Environment Variables

Create a `.env` file in the project root:

```bash
KAFKA_EXTERNAL_HOST=98.81.165.237  # Replace with your EC2 public IP
KAFKA_HOST=kafka                    # Internal Docker hostname
NODE_ENV=development                # Options: development, production
```

### 2. Start the Environment

```bash
# Build and start all services
make start

# Or just bring up the containers
make build
```

### 3. Verify Installation

Access Kafka UI at: `http://<your-ec2-ip>:8080`

Check if Kafka is running:
```bash
docker ps
```

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

- **development && production**: (`<KAFKA_HOST>:9091`) (see .env.example)

Modify the bootstrap server logic in the Makefile as needed for your setup.

## AWS EC2 Security Group Configuration

Ensure these ports are open:

| Port | Service | Access |
|------|---------|--------|
| 2181 | Zookeeper | Optional (internal use) |
| 8080 | Kafka UI | Required for web access |
| 9092 | Kafka | Required for external clients |
