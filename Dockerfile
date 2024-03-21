# Stage 1: Build environment
FROM php:8.3-fpm as builder

# Install system dependencies required for PHP extensions and other tools
RUN apt-get update && apt-get install -y \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        ghostscript \
        imagemagick \
        ffmpeg \
        exiftool \
        antiword \
        xpdf \
        libldap2-dev \
        libzip-dev \
        libxml2-dev \
        libcurl4-openssl-dev \
        libonig-dev \
        gettext-base

# Configure and install PHP extensions recommended for ResourceSpace
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli exif zip ldap mbstring xml curl

# Stage 2: Production environment
FROM php:8.3-fpm

# Copy installed extensions and their configurations from the builder stage
COPY --from=builder /usr/local/etc/php/conf.d /usr/local/etc/php/conf.d
COPY --from=builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
        ghostscript \
        imagemagick \
        ffmpeg \
        exiftool \
        antiword \
        xpdf \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
# Copy the entrypoint script into the container and make it executable
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint script to run on container start
ENTRYPOINT ["entrypoint.sh"]

# The command to run PHP-FPM
CMD ["php-fpm"]
