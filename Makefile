up:
	docker-compose up -d

dev:
	doo b
	doo dc up -d --force-recreate
	docker logs -f jks