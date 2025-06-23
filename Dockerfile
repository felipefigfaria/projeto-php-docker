# Imagem base do PHP
FROM php:8.2-apache

# Define o domínio como variável de ambiente
# ARG DOMAIN=pw.teste.com.br
# ENV DOMAIN=${DOMAIN}

# Define variáveis de ambiente para o PHP
# ENV PHP_MEMORY_LIMIT=512M \
#     PHP_MAX_EXECUTION_TIME=120 \
#     PHP_POST_MAX_SIZE=256M \
#     PHP_UPLOAD_MAX_FILESIZE=256M \
#     PHP_OPCACHE_MEMORY_CONSUMPTION=128 \
#     PHP_OPCACHE_MAX_ACCELERATED_FILES=4000 \
#     PHP_OPCACHE_REVALIDATE_FREQ=60

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-install zip pdo pdo_mysql

# Habilitar mod_rewrite do Apache
RUN a2enmod rewrite

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer

# Definir diretório de trabalho
WORKDIR /var/www/html

# Copiar arquivos do projeto
COPY . .

# Instalar dependências do Composer
RUN composer install --prefer-dist --no-dev --no-interaction --optimize-autoloader

# Configurar permissões
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Configurar Apache
COPY apache/app.conf /etc/apache2/sites-available/000-default.conf

# Expor porta 80
EXPOSE 80

# Comando para iniciar o Apache
CMD ["apachectl", "-D", "FOREGROUND"]