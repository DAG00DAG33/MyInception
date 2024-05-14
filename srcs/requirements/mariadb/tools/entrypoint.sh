# Start MySQL
echo "starting MySQL"
# systemctl start mariadb
# mysqld_safe --skip-grant-tables --skip-networking &
mysqld_safe &

# Wait for MySQL to start
while true; do
    echo "waiting for MySQL to start"
    mysql -e "SELECT 1" &> /dev/null
    if [ $? -eq 0 ]; then
        break
    fi
    sleep 1
done

# Create a database if it doesn't exist
echo "creating database ${SQL_DATABASE}"
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# Create a user if not existing
echo "creating user ${SQL_USER}"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

# Grant privileges to the user from any host
echo "granting privileges to user ${SQL_USER}"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Set new password for root
echo "setting new password for root"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# Apply privilege changes
echo "flushing privileges"
mysql -u root - p $SQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

# Shut down MySQL server
echo "shutting down MySQL server"
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# Start MySQL in safe mode and keep it running
echo "starting MySQL in safe mode"
mysqld_safe --log-error=/var/log/mysql/error.log

# Keep the container running
# tail -f /dev/null