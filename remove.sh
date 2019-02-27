# Remove app directory 
rm -rf ./app

# Create app directory back
mkdir ./app

# Stop all docker containers
docker stop $(docker ps -a -q)

# Remove all specified containers
docker rm docker-wp-ebs-ssl_wordpress_1
docker rm docker-wp-ebs-ssl_phpmyadmin_1
docker rm docker-wp-ebs-ssl_db_1