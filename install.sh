#!/bin/bash

echo -n "Installing jq..."

(
  timeout 8s bash -c '
  while true
  do
    for s in / - \\ \|
    do
      echo -ne "\rInstalling jq... $s"
      sleep 0.1
    done
  done
  '
) &

sudo apt-get install -y jq > /dev/null 2>&1

kill $! > /dev/null 2>&1

echo -ne "\rjq installed successfully!  \n"

read -p "Enter the Cloudflare API key: " CF_API_KEY
read -p "Enter the Cloudflare email: " CF_EMAIL
read -p "Enter the domain name (e.g., example.com): " DOMAIN
read -p "Enter the subdomain to create (e.g., sub.example.com): " SUBDOMAIN

VPS_IP=$(curl -s ifconfig.me)

ZONE_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$DOMAIN" \
    -H "X-Auth-Email: $CF_EMAIL" \
    -H "X-Auth-Key: $CF_API_KEY" \
    -H "Content-Type: application/json" | jq -r '.result[0].id')

if [[ -z "$ZONE_ID" ]]; then
    echo "Error: Failed to retrieve Zone ID. Please check your domain name. Exiting."
    exit 1
fi

echo "Domain: $DOMAIN"
echo "Zone ID: $ZONE_ID"

RESPONSE=$(curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
    -H "X-Auth-Email: $CF_EMAIL" \
    -H "X-Auth-Key: $CF_API_KEY" \
    -H "Content-Type: application/json" \
    --data "{\"type\":\"A\",\"name\":\"$SUBDOMAIN\",\"content\":\"$VPS_IP\",\"ttl\":1,\"proxied\":false}")

if [[ "$RESPONSE" == *'"success":true'* ]]; then
    echo "Subdomain $SUBDOMAIN created successfully with TTL set to Auto."
else
    echo "Failed to create subdomain. Response from Cloudflare: $RESPONSE"
fi
