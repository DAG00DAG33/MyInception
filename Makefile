all: directories
	@docker compose -f srcs/docker-compose.yml up --build

build: directories all

down:
	@docker compose -f srcs/docker-compose.yml down

re: down build

clean:
	@docker compose -f srcs/docker-compose.yml down --volumes --rmi all

fclean: clean rm_directories directories

directories:
	@mkdir -p /home/digarcia/data/mariadb
	@mkdir -p /home/digarcia/data/wordpress

rm_directories:
	@rm -rf /home/digarcia/data/mariadb
	@rm -rf /home/digarcia/data/wordpress



.PHONY: all build down re clean fclean
