all:
	mkdir -p /Users/mpellegr/data/mariadb
	mkdir -p /Users/mpellegr/data/wordpress
	docker compose -f ./srcs/docker-compose.yml up -d

down:
	docker compose -f ./srcs/docker-compose.yml down

clean:
	docker compose -f ./srcs/docker-compose.yml down --volumes --rmi all

fclean: clean
	rm -rf /Users/mpellegr/data

re: fclean
	make all

.PHONY: all up down clean fclean re