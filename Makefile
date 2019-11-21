backend-dev-dockerfiles := -f ./backend/docker-compose.yml -f ./backend/docker-compose.override.yml
webapp-dev-dockerfiles := -f ./web-app/docker-compose.yml -f ./web-app/docker-compose.dev.yml

help:
	@echo "Please use 'make <target>' where <target> is one of the following commands."
	@echo "build-dev               to build the app's development version."
	@echo "run-dev                 to run the app's development version."

build-dev:
	./docker-compose.sh $(backend-dev-dockerfiles) $(webapp-dev-dockerfiles) build
	./docker-compose.sh $(backend-dev-dockerfiles) run web python manage.py migrate
	./docker-compose.sh $(backend-dev-dockerfiles) stop db

run-dev:
	./docker-compose.sh $(backend-dev-dockerfiles) $(webapp-dev-dockerfiles) up
