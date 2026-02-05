.PHONY: up down build logs ps clean help

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

up: ## Start all services in detached mode
	docker compose up -d

down: ## Stop all services
	docker compose down

build: ## Build all service images
	docker compose build

logs: ## Follow logs from all services
	docker compose logs -f

ps: ## Show running containers
	docker compose ps

clean: ## Remove all containers, volumes, and images
	docker compose down -v --rmi all

restart: ## Restart all services
	docker compose restart

shell-cerberus: ## Open shell in cerberus container
	docker compose exec cerberus /bin/sh

shell-genesis: ## Open shell in genesis container
	docker compose exec genesis /bin/sh

shell-postgres: ## Open psql in postgres container
	docker compose exec database psql -U titan -d titan

shell-redis: ## Open redis-cli in redis container
	docker compose exec cache redis-cli
