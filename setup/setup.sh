#!/usr/bin/env bash

echo "Terraform AWS Web Architecture Setup"
echo
echo "This script will create a terraform.tfvars file with your configuration."
echo

validate_domain() {
    local domain=$1
    if [[ $domain =~ ^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    else
        return 1
    fi
}

read -p "Enter project name (default: secure-web): " project_name
project_name=${project_name:-secure-web}

read -p "Enter AWS Access Key: " aws_access_key
if [ -z "$aws_access_key" ]; then
    echo "Error: AWS Access Key is required."
    exit 1
fi

read -s -p "Enter AWS Secret Key: " aws_secret_key
echo
if [ -z "$aws_secret_key" ]; then
    echo "Error: AWS Secret Key is required."
    exit 1
fi

read -p "Enter AWS Region (default: ap-south-1): " aws_region
aws_region=${aws_region:-ap-south-1}

while true; do
    read -p "Enter Domain Name (e.g., example.com): " domain_name
    if validate_domain "$domain_name"; then
        break
    else
        echo "Invalid domain format. Please enter a valid domain (e.g., example.com)."
    fi
done

read -p "Enter Subdomain (e.g., www): " subdomain
if [ -z "$subdomain" ]; then
    echo "Error: Subdomain is required."
    exit 1
fi

cat > terraform.tfvars << EOF
project_name = "$project_name"
aws_access_key = "$aws_access_key"
aws_secret_key = "$aws_secret_key"
aws_region     = "$aws_region"
domain_name    = "$domain_name"
subdomain      = "$subdomain"
EOF

echo
echo "Success: terraform.tfvars created."
echo
echo "Next steps:"
echo "1. Run: terraform init"
echo "Run: terraform validate"
echo "2. Run: terraform plan"
echo "3. Run: terraform apply"
echo
echo "Important: Keep terraform.tfvars secure as it contains sensitive AWS credentials."
