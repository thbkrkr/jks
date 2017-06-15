all:
	doo b
	doo t
	doo p

test:
	doo b
	sudo rm -rf /var/jenkins_home
	docker-compose up --force-recreate