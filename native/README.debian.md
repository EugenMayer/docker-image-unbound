## WAT

Running your own unbound on a debian box

Install unbound dns
```bash
apt install unbound dnsutils vim
```

```bash
vim /etc/unbound/unbound.conf
```

put this inside

``` 
server:
# we disable DNSSEC for now, since it leads to issues
module-config: "iterator"

access-control: 0.0.0.0/0 allow
cache-max-negative-ttl: 10
cache-max-ttl: 86400
cache-min-ttl: 321
do-ip4: yes
do-ip6: no
do-not-query-localhost: no
do-tcp: yes
do-udp: yes
edns-buffer-size: 4096
extended-statistics: yes
harden-dnssec-stripped: yes
harden-large-queries: yes
harden-short-bufsize: yes
interface: 0.0.0.0
logfile: ""
minimal-responses: no
msg-buffer-size: 8192
msg-cache-size: 32m
msg-cache-slabs: 4
num-queries-per-thread: 1024
outgoing-port-permit: "10240-65335"
port: 53
prefetch: yes
rrset-roundrobin: yes
so-reuseport: yes
statistics-cumulative: yes
statistics-interval: 24300
target-fetch-policy: "2 1 0 0 0 0"
trust-anchor: ". DS 19036 8 2 49AAC11D7B6F6446702E54A1607371607A1A41855200FD2CE1CDDE32F24E8FB5"
username: "unbound"
verbosity: 1

include: "/etc/unbound/unbound.conf.d/*.conf"
        
remote-control:
control-enable: no
```

Configure the forward zones (for all requests you cannot resolve locally)

```bash
vim /etc/unbound/unbound.conf.d/03_forward.conf
```

put this inside

``` 
forward-zone:
name: "."
forward-addr: 1.1.1.1
forward-addr: 1.0.0.1
forward-addr: 8.8.4.4
forward-addr: 8.8.8.8
```

and finally, you local DNS entries

```bash
vim /etc/unbound/unbound.conf.d/02_local.conf
```

put this inside. You need to replace `myself.com` with your base domain and then configure the entries ... you get it.

``` 
local-zone: "myself.com" typetransparent

local-data: "gateway.myself.com. A 192.168.1.1"
local-data: "www.gateway.myself.com. A 192.168.1.2"

local-data: "nas.myself.com. A 192.168.1.10"
local-data: "www.nas.myself.com. A 192.168.1.2"

local-data: "homeautomation.myself.com. A 192.168.1.6"
local-data: "www.homeautomation.myself.com. A 192.168.1.2"
```

Now restart the server

```bash
systemctl restart unbound
```

And test

```bash
dig @localhost gateway.myself.com
```

Which should return `192.168.1.1`
