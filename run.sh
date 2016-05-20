#!/bin/sh

set -e

envtpl --keep-template /etc/nginx/nginx.conf.tpl

exec nginx
