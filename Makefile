.PHONY: init config config-publish up up-publish down down-publish ps logs backup update

init:
	./scripts/init.sh

config:
	docker compose config --quiet

config-publish:
	docker compose -f compose.yaml -f compose.publish.yaml config --quiet

up: config
	docker compose up -d

up-publish: config-publish
	docker compose -f compose.yaml -f compose.publish.yaml up -d

down:
	docker compose down

down-publish:
	docker compose -f compose.yaml -f compose.publish.yaml down

ps:
	docker compose ps

logs:
	docker compose logs --follow --tail=100

backup:
	./scripts/backup.sh

update:
	./scripts/update.sh
