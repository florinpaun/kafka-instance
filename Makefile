KAFKA_DOCKER_CONTAINER := kafka
BOOTSRAP_SERVER := kafka:9092

delete-topic:
	docker exec -it $(KAFKA_DOCKER_CONTAINER) kafka-topics --bootstrap-server $(BOOTSRAP_SERVER) --delete --topic $(topic-name)

add-topic:
	docker exec -it $(KAFKA_DOCKER_CONTAINER) kafka-topics --bootstrap-server $(BOOTSRAP_SERVER) --create --topic $(topic-name)

build: ## build the docker images and bring up the environment
	docker compose up -d

start: build

stop: ## stop the environment
	docker compose down