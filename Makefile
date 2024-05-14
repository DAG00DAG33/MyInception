all:
	@docker compose -f srcs/docker-compose.yml up

build:
	@docker compose -f srcs/docker-compose.yml up --build

down:
	@docker compose -f srcs/docker-compose.yml down

re: down build1

clean:
	@docker compose -f srcs/docker-compose.yml down --volumes --rmi all

fclean: clean
	@rm -rf srcs/volumes/mariadb/
	@rm -rf srcs/volumes/wordpress/
	@mkdir srcs/volumes/mariadb
	@mkdir srcs/volumes/wordpress

.PHONY: all build down re clean fclean
