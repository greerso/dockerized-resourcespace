#!/bin/bash
set -e

# Define the path for the PHP custom configuration file
PHP_INI="/usr/local/etc/php/conf.d/custom.php.ini"

# Ensure environment variables are exported for `envsubst` to use them
export UPLOAD_MAX_FILESIZE=${UPLOAD_MAX_FILESIZE:-50M}
export POST_MAX_SIZE=${POST_MAX_SIZE:-50M}
export MEMORY_LIMIT=${MEMORY_LIMIT:-256M}

# Use `envsubst` to replace placeholders in the custom.php.ini.template
# and output the result to the custom PHP configuration file
envsubst '${UPLOAD_MAX_FILESIZE} ${POST_MAX_SIZE} ${MEMORY_LIMIT}' < /custom.php.ini.template > $PHP_INI

# Optional: Add additional startup tasks here

# Execute the main command (e.g., PHP-FPM)
exec "$@"
