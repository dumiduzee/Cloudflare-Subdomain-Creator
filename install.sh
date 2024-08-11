#!/bin/bash
print_color() {
    local color_code="$1"
    shift
    echo -e "\e[${color_code}m$@\e[0m"
}
print_color "32" "Installing jq..."
sudo apt-get install -y jq > /dev/null 2>&1
print_color "32" "jq installed successfully!"

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
    print_color "31" "Error: Failed to retrieve Zone ID. Please check your domain name. Exiting."
    exit 1
fi
print_color "34" "Domain: $DOMAIN"
print_color "34" "Zone ID: $ZONE_ID"
RESPONSE=$(curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
    -H "X-Auth-Email: $CF_EMAIL" \
    -H "X-Auth-Key: $CF_API_KEY" \
    -H "Content-Type: application/json" \
    --data "{\"type\":\"A\",\"name\":\"$SUBDOMAIN\",\"content\":\"$VPS_IP\",\"ttl\":1,\"proxied\":false}")

if [[ "$RESPONSE" == *'"success":true'* ]]; then
    print_color "32" "Subdomain $SUBDOMAIN created successfully with TTL set to Auto."
else
    print_color "31" "Failed to create subdomain. Response from Cloudflare: $RESPONSE"
fi
