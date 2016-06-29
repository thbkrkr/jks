up:
	docker-compose up -d

dev:
	doo b
	doo dc docker-compose.yml down
	doo dc docker-compose.yml up -d
	docker logs -f jenkins