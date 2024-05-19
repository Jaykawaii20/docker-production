# Install and Set Up Laravel with Docker Compose

Setting up Laravel in the server environment with Docker using the LEMP stack that includes: Nginx, MySQL, PHP, and phpMyAdmin.

## Why use Docker for Development

- [x] Consistent development environment for the entire team.
- [x] You don't need to install a bunch of language environments on your system.
- [x] You can use different versions of the same programming language.
- [x] Deployment is easy

# First, Install Docker and Docker Compose
https://docs.docker.com/engine/install/ubuntu/

# Second, set your security groups that allows http, https and ssh that working on 22, 80 and 8080 port
```0.0.0.0/0 or your specific address```

## How to Install and Run the Project

1. ```sudo su```
2. ```cd ~ && cd /var/www```
3. ``` docker login ```
1. ```sudo su```
4. ``` docker pull jaykatagaki/dockerinertia ```
3. ``` git clone git@github.com:vzawft/Docker-Files-Laravel-7.git ```
4. ```sudo docker compose up -d --build```
<!-- 10. ```docker compose exec -uroot app sh```
11. ``` chmod -R 755 storage bootstrap/cache ```
12. ``` chmod -R 755 /var/www/storage ```
13. ```composer install ``` installs laravel packages
14. ```php artisan key:generate``` fills up the APP_KEY
15. ```php artisan migrate``` 
16. ```php artisan optimize``` -->
17. You can see the project on ```your IP4 address in your VPC```

## Reference to clone git repo in Ubuntu

https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent


## If ubuntu VPC can't tract your ssh key in github then:
```ssh-keyscan github.com >> ~/.ssh/known_hosts```
