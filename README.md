# Pluxml docker

Custom php-fpm container for [Pluxml](http://www.pluxml.org/) to be linked with legacy nginx.

```yaml
version: "2"

services:
    pluxml_nginx:
        image: nginx:stable-alpine
        ports:
            - 80
        links:
            - pluxml_php
        volumes_from:
            - pluxml_php

    pluxml_php:
        image: goldy/pluxml

        volumes:
            - ./data/:/var/www/pluxml/data/

        # environment:
        #     INSTALL: add this variable to keep install.php
volumes:
  data: {}

```

This container is using [`pyentrypoint`](https://github.com/cmehay/pyentrypoint) to generate its configuration.
