# # Wait for MySQL to start
while true; do
    echo "waiting for MySQL to start"
    mariadb -h $SQL_HOSTNAME -u $SQL_USER -p$SQL_PASSWORD -e "SELECT 1" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        break
    fi
    sleep 0.5
done

cd /var/www/html

wp --allow-root core is-installed
if [ $? -eq 0 ]
then
	echo "Wordpress already installed."
	# -F specifies php-fpm to run in foreground.
	/usr/sbin/php-fpm7.4 -F
fi

echo "Installing Wordpress..."


echo "Creating config for database {$SQL_DATABASE}"
echo "Data is: $SQL_DATABASE $SQL_USER $SQL_PASSWORD $SQL_HOSTNAME $DOMAIN_NAME $WP_ADMIN_USER $WP_ADMIN_PASSWORD $WP_ADMIN_EMAIL $WP_USER $WP_USER_EMAIL $WP_USER_PASSWORD"
wp --allow-root config create\
  --dbname=$SQL_DATABASE\
  --dbuser=$SQL_USER\
  --dbpass=$SQL_PASSWORD\
  --dbhost=$SQL_HOSTNAME\
  --url=$DOMAIN_NAME \
  --path=/var/www/html

echo "Install"
wp --allow-root core install\
    --url=$DOMAIN_NAME\
    --admin_user=$WP_ADMIN_USER\
    --admin_password=$WP_ADMIN_PASSWORD\
    --admin_email=$WP_ADMIN_EMAIL\
    --title=$DOMAIN_NAME\
    --path=/var/www/html
  
echo "Creating extra user"
wp --allow-root user create $WP_USER $WP_USER_EMAIL \
    --role=editor \
    --user_pass=$WP_USER_PASSWORD \
    --path=/var/www/html


exec /usr/sbin/php-fpm7.4 -F

# Keep the container running
# tail -f /dev/null
