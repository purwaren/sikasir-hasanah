VERSION ?= $(shell git describe --tags --always --dirty --match=v* 2> /dev/null || echo "1.0.0")
APP_DSN := mysql://root:bolo@tcp(127.0.0.1:3306)/cafe
MIGRATE := docker run -v $(shell pwd)/migrations:/migrations --network host migrate/migrate:v4.10.0 -path=/migrations/ -database "$(APP_DSN)"

PID_FILE := './.pid'
FSWATCH_FILE := './fswatch.cfg'

.PHONY: default
default: help

.PHONY: php-run
run: ## run the API server

.PHONY: clean
clean: ## remove temporary files
	rm -rf server coverage.out coverage-all.out

.PHONY: version
version: ## display the version of the API server
	@echo $(VERSION)

.PHONY: db-start
db-start: ## start the database server
	@mkdir -p testdata/mysql
	@docker run --rm --name mariadb -v $(shell pwd)/testdata:/testdata \
		-v $(shell pwd)/testdata/mysql:/var/lib/mysql \
		-e MYSQL_ROOT_PASSWORD=bolo -e MYSQL_DATABASE=kasir -d -p 3306:3306 mariadb

.PHONY: db-stop
db-stop: ## stop the database server
	@docker stop mariadb

.PHONY: php-start
php-start: ## start the php builtin server
	@mkdir -p testdata/log
	@docker run --rm --name cafe \
		-v $(shell pwd):/var/www \
		-v $(shell pwd)/testdata/log:/var/log -d -p 11001:11001 php5.6-mariadb php -S 0.0.0.0:11001 -t /var/www

.PHONY: php-stop
php-stop: ## stop the php builtin server
	@docker stop cafe

.PHONY: testdata
testdata: ## populate the database with test data
	make migrate-reset
	@echo "Populating test data..."
	@docker exec -it mariadb sh -c 'exec mysql --user=root --password=bolo cafe < /testdata/testdata.sql'

.PHONY: migrate
migrate: ## run all new database migrations
	@echo "Running all new database migrations..."
	@$(MIGRATE) up

.PHONY: migrate-down
migrate-down: ## revert database to the last migration step
	@echo "Reverting database to the last migration step..."
	@$(MIGRATE) down 1

.PHONY: migrate-new
migrate-new: ## create a new database migration
	@read -p "Enter the name of the new migration: " name; \
	$(MIGRATE) create -ext sql -dir /migrations/ $${name// /_}

.PHONY: migrate-reset
migrate-reset: ## reset database and re-run all migrations
	@echo "Resetting database..."
	@$(MIGRATE) drop 1
	@echo "Running all database migrations..."
	@$(MIGRATE) up
