# FROM alpine:3.19

# RUN apk update \
# 	&& apk add nginx vim curl openssl

# RUN mkdir -p /etc/nginx/ssl \
# 	&& openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=myevou.42.fr/UID=myevou"

# RUN mkdir -p var/www/nginx
# COPY conf/nginx.conf /etc/nginx/nginx.conf

# RUN chmod 755 /var/www/nginx
# # # RUN addgroup -S www-data && adduser -S www-data -G www-data
# # RUN chown -R www-data:www-data /var/www/nginx
# RUN getent group www-data || addgroup -S www-data
# RUN id -u www-data || adduser -S www-data -G www-data
# RUN chown -R www-data:www-data /var/www/nginx



# CMD ["nginx", "-g", "daemon off;"]


FROM debian:buster

# Install necessary packages
RUN apt-get update \
	&& apt-get install -y nginx vim curl openssl \
	&& rm -rf /var/lib/apt/lists/*  # Clean up package cache to reduce image size

# Create SSL directory and generate the SSL certificates
RUN mkdir -p /etc/nginx/ssl \
	&& openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=myevou.42.fr/UID=myevou"

# Create the NGINX web root directory
RUN mkdir -p /var/www/nginx

# Copy custom NGINX configuration file
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Set appropriate permissions for the NGINX root directory
RUN chmod 755 /var/www/nginx

# Check if www-data user and group exist, and create them if they don't
RUN getent group www-data || addgroup --system www-data
RUN id -u www-data || adduser --system --ingroup www-data www-data

# Change ownership of the web root and SSL directories to the www-data user and group
RUN chown -R www-data:www-data /var/www/nginx /etc/nginx/ssl

# Set the default command to start NGINX
CMD ["nginx", "-g", "daemon off;"]
