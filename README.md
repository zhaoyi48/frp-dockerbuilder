# frp-dockerbuilder
[![Docker Image CI](https://github.com/zhaoyi48/frp-dockerbuilder/actions/workflows/docker-image.yml/badge.svg)](https://github.com/zhaoyi48/frp-dockerbuilder/actions/workflows/docker-image.yml)

### QuickStart
```
docker run -d \
--name frp \
--network host \
--env EXEC_COMMAND=frps -c /etc/frp/frps.ini \
--read-only  -v /root/frp/frps.ini:/etc/frp/frps.ini \
realforcez/frp
```
