# staging

Staging will resolve all FQDNs normally, except domains matching ```*.main.ak.t-online.de```, in which case, the resolver will ingest the ```*.main.ak.t-online.de.edgesuite-staging.net.``` CNAME and will give you an IP from Akamai's staging platform.


For example:

```
~ % nslookup xxxxxx.main.ak.t-online.de 127.0.0.1
Server:		127.0.0.1
Address:	127.0.0.1#53

Non-authoritative answer:
xxxxxx.main.ak.t-online.de	canonical name = xxxxxx.main.ak.t-online.de.edgesuite-staging.net.
xxxxxx.main.ak.t-online.de.edgesuite-staging.net	canonical name = axxxxxx.dscw10.akamai-staging.net.
Name:	axxxxxx.dscw10.akamai-staging.net
Address: 23.50.xxx.xxx
Name:	axxxxxx.dscw10.akamai-staging.net
Address: 23.50.xxx.xxx
```

Standard name resolution (via Google):

```
~ % nslookup xxxxxx.main.ak.t-online.de 8.8.8.8  
Server:		8.8.8.8
Address:	8.8.8.8#53

Non-authoritative answer:
xxxxxx.main.ak.t-online.de	canonical name = xxxxxx.main.ak.t-online.de.edgesuite.net.
xxxxxx.main.ak.t-online.de.edgesuite.net	canonical name = axxxxxx.dscw10.akamai.net.
Name:	axxxxxx.dscw10.akamai.net
Address: 2.17.xxx.xxx
Name:	axxxxxx.dscw10.akamai.net
Address: 2.17.xxx.xxx
```


## Build

```
docker build -t staging .
```

## Run

```
docker run --cap-add=NET_ADMIN -p 53:53 -p 53:53/udp staging
```

## Use

Configure the container as the resolver in your client. 
