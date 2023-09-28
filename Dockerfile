From ubuntu:22.04

Maintainer Rooban

RUN apt update && \
    apt upgrade -y && \
    apt install -y curl gnupg lsb-release && \
    curl https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/cloudflare-client.list && \
    apt update && \
    apt install -y cloudflare-warp

RUN mkdir -p /root/.local/share/warp && echo -n 'yes' > /root/.local/share/warp/accepted-tos.txt

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENV WARP_SLEEP=2

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s --retries=3 \
  CMD curl -fsS "https://cloudflare.com/cdn-cgi/trace" | grep -qE "warp=(plus|on)" || exit 1  

ENTRYPOINT ["/entrypoint.sh"]
