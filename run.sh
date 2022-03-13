#!/bin/sh

mkdir -p /etc/cloudflared

echo ${CREDENTIAL_FILE_CONTENT} > /etc/cloudflared/credentials.json
echo ${CONFIG_FILE_CONTENT_BASE64} | base64 -d > /etc/cloudflared/config.yml

echo "Running cloudflare tunnel..."

cloudflared tunnel --config /etc/cloudflared/config.yml run --force