# Docker Squid Proxy - Strict Whitelist

## [Docker Hub Repository](https://hub.docker.com/r/signaln9ne/squidproxy-strict-whitelist)

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

```
sudo docker built -t signaln9nesquidproxy .
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
