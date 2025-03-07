all:
	make up
up:
	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

clean:
	docker-compose -f ./srcs/docker-compose.yml down --volumes --rmi all

fclean: clean

re: fclean
	make all

.PHONY: all up down clean fclean re