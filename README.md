# AWS Secure Web Architecture

This Terraform project deploys a secure, scalable web architecture on AWS featuring high availability and auto-scaling.

## Architecture Overview

The infrastructure consists of the following components:

### Network Layer

- **VPC**: Isolated virtual network with public and private subnets across multiple availability zones
- **Security Groups**: Configured for Application Load Balancer (ALB) and EC2 instances with appropriate ingress/egress rules

### Compute Layer

- **EC2 Instances**: Auto-scaling group of web servers running in private subnets
- **Launch Template**: Defines EC2 configuration with user data script for Nginx installation
- **User Data**: Automated installation and configuration of Nginx web server serving a "Hello World" page

### Load Balancing & Scaling

- **Application Load Balancer**: Distributes traffic across EC2 instances in multiple availability zones
- **Auto Scaling Group**: Automatically scales EC2 instances based on demand (min 1, max 3 instances)

### Content Delivery & Storage

- **CloudFront CDN**: Global content delivery network for improved performance and security
- **S3 Bucket**: Static asset storage integrated with CloudFront

### Monitoring

- **CloudWatch**: Infrastructure monitoring and logging

## Deployment

1. Run the setup script to configure your variables:
   1. bash:

   ```bash
   ./setup/setup.sh
   ```

   2. PowerShell:

   ```PowerShell
   .\\setup\\setup.ps1
   ```

   This will create a `terraform.tfvars` file with your AWS credentials and domain information.  
   **Tip:** keep `terraform.tfvars` in `.gitignore` to avoid committing sensitive data.

2. Initialize Terraform:

   ```bash
   terraform init
   ```

3. Plan the deployment:

   ```bash
   terraform plan
   ```

4. Apply the configuration:
   ```bash
   terraform apply
   ```

## Access

Once deployed, the web application will be accessible via:

- **CloudFront URL**: `https://<subdomain>.<domain_name>` (HTTP automatically redirects to HTTPS)
- **ALB URL**: For direct access to the load balancer

## Security Features

- Private subnets for EC2 instances (no direct internet access)
- Security groups restricting traffic to necessary ports only
- CDN protection and caching
- S3 bucket secured with Origin Access Control (OAC) policy

## Modules

The project is organized into modular components:

- `network`: VPC, subnets, and internet gateway
- `security`: Security groups
- `loadbalancer`: ALB configuration
- `compute`: EC2 launch template
- `autoscaling`: Auto scaling group
- `monitoring`: CloudWatch alarms
- `storage`: S3 bucket with access policy
- `cdn`: CloudFront distribution
