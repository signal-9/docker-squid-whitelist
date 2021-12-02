# Docker Squid Proxy - Strict Whitelist

## [Docker Hub Repository](https://hub.docker.com/r/signaln9ne/squidproxy-strict-whitelist)

![GitHub last commit](https://img.shields.io/github/last-commit/signal-9/docker-squid-whitelist?color=blue&style=for-the-badge)
![Docker Pulls](https://img.shields.io/docker/pulls/signaln9ne/squidproxy-strict-whitelist?style=for-the-badge)

## docker-compose
```
---
version: "3"
services:
  squidproxy:
    image: signaln9ne/squidproxy-strict-whitelist:latest
    container_name: squidproxy
    volumes:
      - squid-proxy:/config
    ports:
      - 3128:3128
    restart: unless-stopped
volumes:
  squid-proxy:
```

## Build the image

```
git clone https://github.com/signal-9/docker-squid-whitelist.git
cd docker-squid-whitelist
```

Edit ```/etc/squid/squid.conf```, changing the values for:
```
acl localnet src 192.168.1.0/24    # Change to your own network
dns_nameservers 9.9.9.9            # DNS servers (change if you want)
```

and ```/etc/squid/whitelist.txt```, adding or removing domains as you wish.  Any domains in this list will be reachable, any that are not will be denied.

Once the container is running, you can edit these documents in ```/etc/squid``` as needed.  ```whitelist.txt``` will need the most adjusting.

## Run the container

```
sudo docker build -t signaln9nesquidproxy .
docker volume create squid
docker run -dit \
    -p 3128:3128 \
    --name=squidproxy \
    --restart=always \
    -v squid:/etc/squid \
    signaln9nesquidproxy
```
Point your client machines to the container IP port 3128.  Only approved domains in the ```whitelist.txt``` file should be accessible.

You can ```tail -f /var/log/squid/access.log``` to see what domains are being approved, denied, etc.
