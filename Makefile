name = inception
COMPOSE_FILE = ./srcs/docker-compose.yml

# -f we use this flag when we want to specify which docker compose file we want to use
# and where it is located
# becuae by default we don't need to write the name of the file
# docker-compose up -d will search for the file in the directory.
# but if we changed the name from docker-compose-yml or the path then we need -f

all: build up

# Run containers in detached mode
up:
	@printf "Launching the configuration ${name}...\n"
	@docker-compose -f $(COMPOSE_FILE) up -d

# Build images and run containers
build:
	@printf "Assembling the configuration ${name}...\n"
	@docker-compose -f $(COMPOSE_FILE) up -d --build

# rebuild and re-run
re: clean build up

# Stop and remove containers, networks, and volumes created by docker-compose up
down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose -f $(COMPOSE_FILE) down

# Remove all containers and images
clean:
	@echo "WARNING! This will remove:"
	@echo "  - All stopped containers"
	@echo "  - All networks not used by at least one container"
	@echo "  - All images not used by any container"
	@echo "  - All build cache"
	@read -p "Are you sure you want to continue? [y/N] " \
	CONFIRM && [ "$$CONFIRM" = "y" ] && \
	$(MAKE) down && docker system prune -a --force \
	|| echo "Operation canceled."

# docker system prune : Removes stopped containers, dangling images (unused layers), unused networks, unused build cache, Does NOT remove volumes by default.
# -a : Removes all unused images, even those not dangling (i.e., images that are not used by any running/stopped container).
# so it doesn't remove the running containers. that's why we need down in clean command
# funny info: [y/N] is more used than [n/y], because it means NO is the default value if the
# user pressed enter without typing any character:D
# --force skips confirmation prompts. we already used echo

# Remove all containers and images + all Docker networks and volumes
fclean:
	@echo "Total clean of all Docker configurations"
	@echo "WARNING! This will remove:"
	@echo "  - All stopped and running containers"
	@echo "  - All unused images (not just dangling ones)"
	@echo "  - All unused networks"
	@echo "  - All unused volumes"
	@read -p "Are you sure you want to continue? [y/N] " CONFIRM && [ "$$CONFIRM" = "y" ] && \
	docker stop $$(docker ps -qa) && \
	docker system prune --all --force --volumes && \
	docker network prune --force && \
	docker volume prune --force || echo "Operation canceled."

# read: shell command to take the user input
# -p: to dispaly the prompt before reading the input
# CONFIRM: the variable where the input will be stored
# $$CONFIRM: = "y" :the value inside this variable is it "y" ?
# if true it will run the next command
# || means run the left side of the command if the right side failed

.PHONY	: all up build down re clean fclean
