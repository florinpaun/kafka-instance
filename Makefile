KAFKA_DOCKER_CONTAINER := kafka
BOOTSRAP_SERVER := kafka:9092

create-topic:
	docker exec -it $(KAFKA_DOCKER_CONTAINER) kafka-topics --create --bootstrap-server $(BOOTSRAP_SERVER) --topic $(topic-name) --partitions 1 --replication-factor 1
# Target that demonstrates both variables

delete-topic:
	docker exec -it kafka kafka-topics --bootstrap-server $(BOOTSRAP_SERVER) --delete --topic $(topic-name)

build: ## build the docker images and bring up the environment
	docker compose up -d

start: build

stop: ## stop the environment
	docker compose down