<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cloudflare Subdomain Creator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
            color: #333;
        }
        h1, h2, h3 {
            color: #2c3e50;
        }
        h1 {
            font-size: 2.5em;
        }
        code {
            background-color: #e6e6e6;
            padding: 2px 5px;
            border-radius: 4px;
            font-size: 1.1em;
        }
        .command {
            background-color: #333;
            color: #fff;
            padding: 10px;
            border-radius: 5px;
            font-size: 1.1em;
        }
        .emoji {
            font-size: 1.5em;
        }
        ul {
            list-style-type: none;
            padding-left: 0;
        }
        ul li {
            padding-left: 20px;
            text-indent: -20px;
        }
        ul li:before {
            content: "🌟";
            padding-right: 10px;
        }
    </style>
</head>
<body>

    <h1>🌐 Cloudflare Subdomain Creator</h1>

    <p>Welcome to the <strong>Cloudflare Subdomain Creator</strong>! This tool allows you to effortlessly create subdomains on Cloudflare using a simple bash script.</p>

    <h2>🚀 How to Use</h2>

    <p>To get started, simply run the following command in your terminal:</p>

    <div class="command">
        <code>bash &lt;(curl -Ls https://raw.githubusercontent.com/dumiduzee/Cloudflare-Subdomain-Creator/main/install.sh)</code>
    </div>

    <h2>📋 What This Script Does</h2>

    <ul>
        <li>Installs <code>jq</code> if it's not already installed.</li>
        <li>Prompts you to enter your Cloudflare API key, email, domain name, and the subdomain you want to create.</li>
        <li>Automatically retrieves your VPS IP address.</li>
        <li>Fetches the Zone ID for your domain from Cloudflare.</li>
        <li>Creates a new A record for your subdomain pointing to your VPS IP.</li>
    </ul>

    <h2>⚠️ Prerequisites</h2>

    <ul>
        <li>A Cloudflare account with API access.</li>
        <li>Your Cloudflare API key and email.</li>
        <li>The domain name you wish to create a subdomain for must already be registered in your Cloudflare account.</li>
    </ul>

    <h2>💡 Example Usage</h2>

    <p>After running the command, you'll be prompted to enter the following details:</p>
    <ul>
        <li>Your Cloudflare API key.</li>
        <li>Your Cloudflare email.</li>
        <li>The domain name (e.g., <code>example.com</code>).</li>
        <li>The subdomain you wish to create (e.g., <code>sub.example.com</code>).</li>
    </ul>
    <p>The script will then handle the rest, creating the subdomain and providing confirmation.</p>

    <h2>🛠 Troubleshooting</h2>

    <p>If you encounter any issues, ensure that:</p>
    <ul>
        <li>Your API key and email are correct.</li>
        <li>Your domain name is registered in your Cloudflare account.</li>
        <li>You have sufficient permissions in your Cloudflare account to create DNS records.</li>
    </ul>

    <h2>📞 Support</h2>

    <p>If you need any help or have questions, feel free to open an issue on the <a href="https://github.com/dumiduzee/Cloudflare-Subdomain-Creator">GitHub repository</a>.</p>

</body>
</html>
