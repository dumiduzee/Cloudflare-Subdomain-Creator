#!/bin/bash

# Install jq if not already installed
echo "Installing jq..."
sudo apt-get install -y jq

# Get user input
read -p "Enter the Cloudflare API key: " CF_API_KEY
read -p "Enter the Cloudflare email: " CF_EMAIL
read -p "Enter the subdomain to create (e.g., sub.example.com): " SUBDOMAIN

# Automatically get the VPS IP address
VPS_IP=$(curl -s ifconfig.me)

# Extract the domain name from the subdomain
DOMAIN=$(echo $SUBDOMAIN | awk -F'.' '{print $(NF-1)"."$NF}')

# Get the Zone ID and ensure it's a single value
ZONE_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$DOMAIN" \
    -H "X-Auth-Email: $CF_EMAIL" \
    -H "X-Auth-Key: $CF_API_KEY" \
    -H "Content-Type: application/json" | jq -r '.result[0].id')

# Check if the Zone ID was retrieved successfully and only one ID was retrieved
if [[ -z "$ZONE_ID" ]]; then
    echo "Error: Failed to retrieve Zone ID. Exiting."
    exit 1
elif [[ $(echo "$ZONE_ID" | wc -l) -ne 1 ]]; then
    echo "Error: Multiple Zone IDs retrieved. Exiting."
    exit 1
fi

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
