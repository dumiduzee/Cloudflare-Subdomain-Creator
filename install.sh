#!/bin/bash

echo "Insatalling sudo apt-get install -y jq"
sudo apt-get install -y jq


# Get user input
read -p "Enter the Cloudflare API key: " CF_API_KEY
read -p "Enter the Cloudflare email: " CF_EMAIL
read -p "Enter the subdomain to create (e.g., sub.example.com): " SUBDOMAIN

# Automatically get the VPS IP address
VPS_IP=$(curl -s ifconfig.me)

# Extract the domain name from the subdomain
DOMAIN=$(echo $SUBDOMAIN | awk -F'.' '{print $(NF-1)"."$NF}')

# Set the Zone ID
ZONE_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$DOMAIN" \
    -H "X-Auth-Email: $CF_EMAIL" \
    -H "X-Auth-Key: $CF_API_KEY" \
    -H "Content-Type: application/json" | grep -oP '"id":"\K[^"]+')

echo "Domain: $DOMAIN"
echo "Zone ID: $ZONE_ID"

# Create the DNS record
RESPONSE=$(curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
    -H "X-Auth-Email: $CF_EMAIL" \
    -H "X-Auth-Key: $CF_API_KEY" \
    -H "Content-Type: application/json" \
    --data "{\"type\":\"A\",\"name\":\"$SUBDOMAIN\",\"content\":\"$VPS_IP\",\"ttl\":120,\"proxied\":false}")

# Check if the record was created successfully
if [[ "$RESPONSE" == *'"success":true'* ]]; then
    echo "Subdomain $SUBDOMAIN created successfully."
else
    echo "Failed to create subdomain. Response from Cloudflare: $RESPONSE"
fi
