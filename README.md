```shell
docker buildx build \
  --cache-to=type=local,dest=/Users/pro/Desktop/workspace,mode=max \
  --cache-from=type=local,src=/Users/pro/Desktop/workspace \
  --tag swift-docker-vapor:lastest \
  .
```