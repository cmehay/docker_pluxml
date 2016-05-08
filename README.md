# Pluxml docker

Custom php-fpm container for [Pluxml](http://www.pluxml.org/) to be linked with legacy nginx.

```yaml
pluxml_php:
    build: .

    volumes:
        - ./data/:/var/www/pluxml/data/ # Keep data

    # environment:
    #     INSTALL: add this variable to keep install.php

pluxml_nginx:
    image: nginx:stable-alpine # Legacy nginx
    expose:
        - 80
    links:
        - pluxml_php # Link container here
    volumes_from:
        - pluxml_php # mount volume here to add nginx configuration

```

This container is using [`pyentrypoint`](https://github.com/cmehay/pyentrypoint) to generate its configuration.
