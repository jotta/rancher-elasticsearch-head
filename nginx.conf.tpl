daemon off;
user www-data;
worker_processes 4;
pid /run/nginx.pid;

events {
  worker_connections 1024;
}

http {
  sendfile on;
  tcp_nopush on;
  tcp_nodelay on;
  keepalive_timeout 65;
  types_hash_max_size 2048;
  include /etc/nginx/mime.types;
  default_type application/octet-stream;

  access_log /dev/stdout;
  error_log /dev/stderr;

 upstream es {
    {% for server in HEAD_ES_SERVERS.split(",") %}
    server {{ server }};
    {% endfor %}
  }

  server {
    listen 80;

    server_name {{ HEAD_SERVER_NAME }};

    satisfy any;

    # suppress passing basic auth to upstreams
    proxy_set_header Authorization "";

    # everybody loves caching bugs after upgrade
    expires -1;

    location / {
      root /head/;
      rewrite ^/$ 'index.html?base_uri=/es/' permanent;
    }

    location /es/ {
      rewrite ^/es/(.*)$ /$1 break;
      proxy_pass http://es;
    }

  }
}
