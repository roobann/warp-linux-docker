# warp-linux-docker
Docker container for warp-cli

```
version: "3.0"
  warp:
    image: ghcr.io/roobann/warp-linux-docker:latest
    container_name: warp
    restart: always
    environment:
      - WARP_SLEEP=2
      - WARP_LICENSE_KEY=<key> #optional
    cap_add:
      - NET_ADMIN
    sysctls:
      - net.ipv6.conf.all.disable_ipv6=1
      - net.ipv4.conf.all.src_valid_mark=1
    volumes:
      - /path/to/local:/var/lib/cloudflare-warp
```
This can be used with other container by specifiying `network_mode: service:warp`
