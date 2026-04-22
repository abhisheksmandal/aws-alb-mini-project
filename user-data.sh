#!/bin/bash
# Update packages
apt update -y

# Install Nginx
apt install -y nginx

# Fetch instance metadata using IMDSv2
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/instance-id)

AZ=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/placement/availability-zone)

# Create custom HTML page
cat > /usr/share/nginx/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Hello World</title>
    <style>
        body {
            text-align: center;
            font-family: Arial, sans-serif;
            margin-top: 100px;
            background-color: #f4f6f8;
        }
        .card {
            display: inline-block;
            background: white;
            padding: 40px 60px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }
        h1 { color: #232f3e; }
        p  { color: #555; font-size: 16px; }
        strong { color: #e47911; }
    </style>
</head>
<body>
    <div class="card">
        <h1>Hello World!</h1>
        <p>Instance ID: <strong>${INSTANCE_ID}</strong></p>
        <p>Availability Zone: <strong>${AZ}</strong></p>
        <p>Served by: <strong>Nginx</strong></p>
    </div>
</body>
</html>
EOF

# Start and enable Nginx
systemctl start nginx
systemctl enable nginx