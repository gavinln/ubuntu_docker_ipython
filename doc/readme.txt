This VM demonstrates using docker with a ubuntu VM that supports docker and supports virtual box shared folders (vboxsf)

sudo docker run \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:rw \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --publish=8080:8080 \
  --detach=true \
  --name=cadvisor \
  google/cadvisor:latest




docker run -t -i phusion/baseimage:latest /sbin/my_init -- bash -l
