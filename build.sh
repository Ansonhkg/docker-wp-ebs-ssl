#!/bin/bash
CONTAINER='localhost:80'

# Run Docker container here
echo "==================== CREATING CONTAINERS ===================="
docker-compose up -d --build
echo ""

echo "==================== WAITING FOR SERVICES TO BE UP. ===================="
echo "*** This might take up to 30 seconds.. If not please CTRL+C to exit. ***"
echo ""
until curl -s $CONTAINER > /dev/null; do
  echo '> Waiting' $CONTAINER 'to be up...'
  sleep 3
done
echo ""


echo "==================== EXECUTING POST-BUILD OPERATIONS ===================="
# Do your docker exec stuff here
cp ./post_build/.htaccess ./app
cp ./post_build/wp-config.php ./app

echo "DONE - "$CONTAINER" is up."