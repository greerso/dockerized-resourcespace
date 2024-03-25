#!/bin/bash
set -e

# Example setup task: Ensure permissions are correct
chown -R www-data:www-data /var/www/html

# Optionally, perform actions like waiting for dependent services to be ready
# echo "Waiting for database..."
# wait-for-it.sh mariadb:3306 -- echo "Database is up."

# Define the path for the PHP custom configuration file
PHP_INI="/usr/local/etc/php/conf.d/custom.php.ini"

# Optional: Add additional startup tasks here

# Execute the main command (e.g., PHP-FPM)
exec "$@"
