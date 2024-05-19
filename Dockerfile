FROM php:7.4-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    libzip-dev \
    libonig-dev \
    unzip \
    git \
    curl


# # Copy composer.lock and composer.json
# COPY composer.lock composer.json /var/www/

# Create /var/www directory and navigate to it
RUN mkdir /var/www && cd /var/www

# Set working directory
WORKDIR /var/www

# # Copy SSH keys to the container
# COPY id_rsa /root/.ssh/id_rsa
# COPY id_rsa.pub /root/.ssh/id_rsa.pub

# # Set the appropriate permissions for the SSH keys
# RUN chmod 600 /root/.ssh/id_rsa && \
#     ssh-keyscan github.com >> /root/.ssh/known_hosts

#RUN echo "#!/bin/bash" >> /tmp/clone.sh

RUN echo "git clone git@github.com:vzawft/laravel-jetstream-inertia-vue3-nova3.git"

# RUN chmod 700 /tmp/clone.sh

# ENTRYPOINT ["/tmp/clone.sh"]
    
# Copy the contents from one repository to another
RUN cp -R Docker-Files-Laravel-7/. laravel-jetstream-inertia-vue3-nova3
    
# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl
#RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-install gd

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory contents
COPY . /var/www

# Copy existing application directory permissions
COPY --chown=www:www . /var/www

# Set permissions for storage and bootstrap/cache directories
RUN chmod -R 755 /var/www/laravel-jetstream-inertia-vue3-nova3/storage /var/www/laravel-jetstream-inertia-vue3-nova3/bootstrap/cache
RUN chmod -R 755 /var/www/storage

# Set the working directory to laravel-jetstream-inertia-vue3-nova3
WORKDIR /var/www/laravel-jetstream-inertia-vue3-nova3

# Install PHP dependencies
RUN composer install

# Run Laravel commands
RUN php artisan key:generate
RUN php artisan migrate --force
RUN php artisan optimize

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]