# WAT

Unbound DNS resolve / cache / validate [unbound.net](https://unbound.net/)

Unbound Version: 1.8.1
OpenSSL Version: 1.1.1

See 
## Start

Run this container with the following command:

```console
docker-compose up
# replace 127.0.0.1 with your docker-machine ip
dig -p55 @127.0.0.1 gateway.myself.com
dig -p55 @127.0.0.1 google.de
```

For more examples also see 

## Custom records

Just mount(create) `/etc/unbound/conf.d/01_records.conf` with your own record config looking somewhat like this

```
local-data: "gateway.myself.com. A 192.168.1.1"
local-data: "www.gateway.myself.com. A 192.168.1.2"

local-data: "nas.myself.com. A 192.168.1.10"
local-data: "www.nas.myself.com. A 192.168.1.2"

local-data: "homeautomation.myself.com. A 192.168.1.6"
local-data: "www.homeautomation.myself.com. A 192.168.1.2"
```

## Custom configuration
Mount any configuration under `/etc/unbound/conf.d/my-custom.conf`, for example to forward all request to public dns

`/etc/unbound/conf.d/02_forward.conf`
```
forward-zone:
    name: "."
        forward-addr: 1.1.1.1        # Cloudflare
        forward-addr: 1.0.0.1        # Cloudflare
        forward-addr: 8.8.4.4        # Google
        forward-addr: 8.8.8.8        # Google
``` 

## Build

```bash
make init
make build
```

## Credits

Of course credits to [unbound.net](https://unbound.net/)