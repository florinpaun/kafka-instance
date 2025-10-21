include .env
export

KAFKA_DOCKER_CONTAINER := kafka

# Set BOOTSTRAP_SERVER based on NODE_ENV
ifeq ($(NODE_ENV),production)
    BOOTSTRAP_SERVER := $(KAFKA_HOST):29092
else ifeq ($(NODE_ENV),development)
    BOOTSTRAP_SERVER := $(KAFKA_HOST):9092
else
    # Default to development (internal Docker network)
    BOOTSTRAP_SERVER := $(KAFKA_HOST):9092
endif

.PHONY: build start stop add-topic delete-topic

delete-topic: ## Delete a topic (usage: make delete-topic topic-name=my-topic)
	@echo "Using Bootstrap Server: $(BOOTSTRAP_SERVER)"
	docker exec -it $(KAFKA_DOCKER_CONTAINER) kafka-topics --bootstrap-server $(BOOTSTRAP_SERVER) --delete --topic $(topic-name)

add-topic: ## Create a new topic (usage: make add-topic topic-name=my-topic)
	@echo "Using Bootstrap Server: $(BOOTSTRAP_SERVER)"
	docker exec -it $(KAFKA_DOCKER_CONTAINER) kafka-topics --bootstrap-server $(BOOTSTRAP_SERVER) --create --topic $(topic-name)

build: ## Build the docker images and bring up the environment
	docker compose up -d

start: build ## Start the environment

stop: ## Stop the environment
	docker compose down