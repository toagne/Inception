all:
	@if ! grep -q mpellegr /etc/hosts; then \
		echo 127.0.0.1	mpellegr.42.fr | sudo tee -a /etc/hosts; \
	fi
	@mkdir -p ~/data/mariadb
	@mkdir -p ~/data/wordpress
	docker compose -f ./srcs/docker-compose.yml up -d

down:
	docker compose -f ./srcs/docker-compose.yml down

clean:
	docker compose -f ./srcs/docker-compose.yml down --volumes --rmi all
	docker system prune -af

fclean: clean
	sudo rm -rf ~/data
	@if [ "$(shell uname)" = "Darwin" ]; then \
		sudo sed -i '' '/mpellegr.42.fr/d' /etc/hosts; \
	else \
		sudo sed -i '/mpellegr.42.fr/d' /etc/hosts; \
	fi

re: fclean
	make all

.PHONY: all up down clean fclean re
