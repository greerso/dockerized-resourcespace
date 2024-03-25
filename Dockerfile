# Stage 1: Build environment
FROM php:8.3-fpm as builder

# Install SVN and other dependencies required for PHP extensions and ResourceSpace
RUN apt-get update && apt-get install -y \
        subversion \
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
        gettext-base \
    && rm -rf /var/lib/apt/lists/*

# Checkout the latest ResourceSpace code
RUN svn checkout http://svn.resourcespace.com/svn/rs/releases/[release_version] /var/www/html

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli exif zip ldap mbstring xml curl

# Stage 2: Production environment
FROM php:8.3-fpm

# Copy the built PHP extensions and the ResourceSpace code
COPY --from=builder /usr/local/etc/php/conf.d /usr/local/etc/php/conf.d
COPY --from=builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --from=builder /var/www/html /var/www/html

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

ENTRYPOINT ["entrypoint.sh"]
CMD ["php-fpm"]
