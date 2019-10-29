help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

up: ## Creates the docker-compose stack.
	-docker swarm init
	docker-compose -f ops/docker-compose/docker-compose.yml --project-name project up -d

down: ## Deletes the docker-compose stack.  Your local environment will no longer be accessible.
	docker-compose -f ops/docker-compose/docker-compose.yml --project-name project down

init: ## Initialise local environment
	mkdir -p var/cache/dev var/cache/prod var/logs var/sessions
	$(MAKE) up
	$(MAKE) composer-install
	$(MAKE) db-create
	$(MAKE) db-update
	docker cp sql/fixtures postgres:/fixtures
	docker exec -ti db psql -d project -f /fixtures/pgsql_fixtures.sql
	docker exec php bash -c "chmod -R 777 var/cache/dev var/cache/prod var/logs var/sessions"
	$(MAKE) down

ca-cl: ## Clears the symfony cache
	docker exec php bash -c "php bin/console cache:clear"

composer-install: ## Install symfony vendors
	docker exec php bash -c "composer install"

db-create: ## Uses doctrine:schema:create to create database
	docker exec php bash -c "php bin/console doctrine:database:create"

db-update: ## Uses doctrine:schema:update to update database
	docker exec php -c "php bin/console doctrine:schema:update --force"

.PHONY: up down ca-cl composer-install help