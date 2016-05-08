server {
    listen       80;
    server_name  localhost;

    access_log /dev/stdout  main;
    error_log /dev/stderr warn;

    root /var/www/pluxml;

    location / {
        # Example PHP configuration
        index index.php;
        try_files $uri $uri/ index.php;
        location ~ [^/]\.php(/|$) {
            fastcgi_split_path_info ^(.+?\.php)(/.*)$;
            fastcgi_pass {{ env['HOSTNAME'] }}:9000;
            fastcgi_index index.php;
            include fastcgi_params;
            fastcgi_param REMOTE_USER $remote_user;
            fastcgi_param PATH_INFO $fastcgi_path_info;
            fastcgi_param SCRIPT_FILENAME $request_filename;
        }
        # Avoid .htaccess
        location ~ /\.ht {
            deny all;
        }

        location /.git {
            deny all;
            return 403;
        }

        location /version {
            return 403;
        }
        location /data/configuration/users.xml {
            return 403;
        }
        location /data/medias {
            allow all;
            break;
        }
        location /data {
          deny all;
          return 403;
        }
        if (-f $request_filename) {
            break;
        }
        # URL rewriting
        if (!-e $request_filename) {
            rewrite ^/([^feed\/].*)$ /index.php?$1 last;
            rewrite ^/feed\/(.*)$ /feed.php?$1 last;
            break;
        }
    }
}
