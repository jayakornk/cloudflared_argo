FROM alpine:3.14

RUN \
    CVERSION="latest/download" \
    && apk add --no-cache libc6-compat yq \
    && wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/$CVERSION/cloudflared-linux-arm64 && chmod +x /usr/local/bin/cloudflared

RUN cloudflared -v

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]