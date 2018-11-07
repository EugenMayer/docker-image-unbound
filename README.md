# WAT

Unbound DNS resolve / cache / validate [unbound.net](https://unbound.net/)

## start

Run this container with the following command:

```console
docker-compose up
# replace 127.0.0.1 with your docker-machine ip
dig -p55 @127.0.0.1 gateway.myself.com
dig -p55 @127.0.0.1 google.de
```

## Custom records

Just mount `/etc/unbound/records.conf` with your own record config looking somewhat like this

```
local-data: "gateway.myself.com. A 192.168.1.1"
local-data: "www.gateway.myself.com. A 192.168.1.2"

local-data: "nas.myself.com. A 192.168.1.10"
local-data: "www.nas.myself.com. A 192.168.1.2"

local-data: "homeautomation.myself.com. A 192.168.1.6"
local-data: "www.homeautomation.myself.com. A 192.168.1.2"
```

## Build

```bash
make init
make build
```

## Credits

Of course credits to [unbound.net](https://unbound.net/)