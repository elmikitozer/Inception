# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: myevou <myevou@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/24 17:47:38 by myevou            #+#    #+#              #
#    Updated: 2024/11/24 17:47:41 by myevou           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


name = inception

# createVolumes
MARIADB=/home/myevou/data/mariadb
WORDPRESS=/home/myevou/data/wordpress

all: buildup

	mkdir -p $(MARIADB)
	mkdir -p $(WORDPRESS)


buildup:
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

re: clean all

clean: down
	@printf "Cleaning up Docker containers, images, and volumes...\n"
	@docker stop $(docker ps -qa) || true
	@docker rm $(docker ps -qa) || true
	@docker rmi -f $(docker images -q) --force || true
	@docker volume rm $(docker volume ls -q) || true
	@docker network rm $(docker network ls -q) 2>/dev/null || true
	@docker system prune -a -f || true

.PHONY	: all build down re clean
