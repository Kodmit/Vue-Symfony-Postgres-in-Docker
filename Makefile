help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

up: ## Creates the docker-compose stack.
	-docker swarm init
	docker-compose up -d

down: ## Deletes the docker-compose stack.  Your local environment will no longer be accessible.
	docker-compose down

init: ## Initialise local environment
	$(MAKE) up
	$(MAKE) composer-install
	$(MAKE) db-create
	$(MAKE) db-update
	$(MAKE) down

ca-cl: ## Clears the symfony cache
	docker exec app_php bash -c "cd symfony && php bin/console cache:clear"

composer-install: ## Install symfony vendors
	docker exec app_php bash -c "cd symfony && composer install"

db-create: ## Uses doctrine:schema:create to create database
	docker exec app_php bash -c "cd symfony && php bin/console doctrine:database:create"

db-update: ## Uses doctrine:schema:update to update database
	docker exec app_php bash -c "cd symfony && php bin/console doctrine:schema:update --force"

.PHONY: up down ca-cl composer-install help