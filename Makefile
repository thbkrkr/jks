all:
	doo b
	doo t
	doo p

up:
	docker-compose up -d

dev:
	doo b
	doo dc docker-compose.yml up -d --force-recreate
	docker logs -f jenkins