# Ref: https://github.com/PanJ/hassio-addons/blob/main/cloudflare_argo/Dockerfile

FROM alpine:3.15

ARG TARGETPLATFORM
ARG TARGETARCH
ARG BUILDPLATFORM

ARG BUILD_ARCH
RUN \
    CVERSION="latest/download" \
    ARCH="${TARGETARCH}" \
    && if [[ "${TARGETARCH}" = "arm64" ]]; then ARCH="arm64"; fi \
    && if [[ "${TARGETARCH}" = "amd64" ]]; then ARCH="amd64"; fi \
    && if [[ "${TARGETARCH}" = "arm" ]]; then ARCH="arm"; fi \
    && if [[ "${TARGETARCH}" = "386" ]]; then ARCH="386"; fi \
    && apk add --no-cache libc6-compat yq \
    && wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/$CVERSION/cloudflared-linux-$ARCH && chmod +x /usr/local/bin/cloudflared

# RUN \
#     CVERSION="latest/download" \
#     && apk add --no-cache libc6-compat yq \
#     && wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/$CVERSION/cloudflared-linux-arm64 && chmod +x /usr/local/bin/cloudflared

RUN cloudflared -v

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]