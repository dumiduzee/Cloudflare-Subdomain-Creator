
# 🌐Cloudflare Subdomain Creator

Welcome to the **Cloudflare Subdomain Creator**! This tool allows you to effortlessly create subdomains on Cloudflare using a simple bash script.

## 🚀 How to Use

To get started, simply run the following command in your terminal:

```bash
bash <(curl -Ls https://raw.githubusercontent.com/dumiduzee/Cloudflare-Subdomain-Creator/main/install.sh)
```






## 📋 What This Script Does

 - Installs jq if it's not already installed.
 - Prompts you to enter your Cloudflare API key, email, domain name, and the subdomain you want to create
 - Automatically retrieves your VPS IP address.
  - Fetches the Zone ID for your domain from Cloudflare.
- Creates a new A record for your subdomain pointing to your VPS IP.

## ⚠️ Prerequisites
- A Cloudflare account with API access.
- Your Cloudflare API key and email.
- The domain name you wish to create a subdomain for must already be registered in your Cloudflare account.

## 💡 Example Usage
- After running the command, you'll be prompted to enter the following details:

- Your Cloudflare API key.
- Your Cloudflare email.
- The domain name (e.g., example.com).
- The subdomain you wish to create (e.g., sub.example.com).
- The script will then handle the rest, creating the subdomain and providing confirmation.



## 🔗 Links
[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://zeuslk.xyz/)
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/dumidu-lakshan-345a14320/)


