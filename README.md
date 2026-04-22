# 🚀 Highly Available Nginx Web App on AWS

## 📌 Architecture Overview

This project demonstrates how to deploy a **highly available, secure
"Hello World" Nginx web application** on AWS using best practices.

The architecture includes: - Custom VPC across 2 Availability Zones -
Private EC2 instances (no public exposure) - Application Load Balancer (ALB)

------------------------------------------------------------------------

## 🧩 Key Components

### 🌐 Networking

-   VPC: 10.0.0.0/16
-   Public & Private Subnets across:
    -   ap-south-1a
    -   ap-south-1b
-   Internet Gateway (IGW)
-   NAT Gateway

### 🔐 Security

-   ALB Security Group: Public HTTP access
-   EC2 Security Group: Only allows traffic from ALB
-   IAM Role: Enables SSM access

### 🖥️ Compute

-   2 × Ubuntu 24.04 EC2 instances (t3.micro)
-   Nginx web server
-   Dynamic metadata display

------------------------------------------------------------------------

## ⚙️ Phase 1: Network & Security Provisioning

### Create VPC

-   Name: Hello-World-VPC
-   CIDR: 10.0.0.0/16

### Create Subnets

-   Public-Subnet-A (10.0.1.0/24)
-   Public-Subnet-B (10.0.2.0/24)
-   Private-Subnet-A (10.0.3.0/24)
-   Private-Subnet-B (10.0.4.0/24)

### Gateways & Routing

-   Internet Gateway attached to VPC
-   NAT Gateway in Public-Subnet-A

### Route Tables

Public: 0.0.0.0/0 → IGW

Private: 0.0.0.0/0 → NAT Gateway

------------------------------------------------------------------------

## ⚙️ Phase 2: Compute & Load Balancing

### EC2 Setup

-   Ubuntu 24.04
-   t3.micro
-   2 instances in private subnets

### User Data Script

``` bash
#!/bin/bash
apt update -y
apt install -y nginx
systemctl start nginx
systemctl enable nginx
```

### Load Balancer

-   Internet-facing ALB
-   Listener: HTTP 80
-   Target Group: EC2 instances

------------------------------------------------------------------------

## ✅ Result

Access ALB DNS to view Hello World page with instance details.

------------------------------------------------------------------------

## 🚀 Improvements

-   Auto Scaling Group
-   HTTPS (ACM)
-   CI/CD pipeline
-   Monitoring with CloudWatch
