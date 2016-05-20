# rancher-elasticsearch-head
Rancher Elasticsearch Head plugin

Inspired by elasticsearch kopf plugin we built a container for the head plugin.

Build image:
```
docker build --no-cache -t 'jotta/rancher-elasticsearch-head:0.2' .
```

Tag and push to repo:

```
docker tag jotta/rancher-elasticsearch-head:0.2 [DOCKERREGISTRY]/jotta/rancher-elasticsearch-head:0.2
docker push [DOCKERREGISTRY]/jotta/rancher-elasticsearch-head:0.2
```

docker-compose.yml:
```
head:
  image: [DOCKERREGISTRY]/jotta/rancher-elasticsearch-head:0.2
  ports:
    - "80/tcp"
  environment:
    HEAD_SERVER_NAME: 'es.dev'
    HEAD_ES_SERVERS: 'es-clients:9200'
  labels:
    io.rancher.container.hostname_override: container_name
  links:
    - elasticsearch-clients:es-clients
```
