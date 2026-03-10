#!/usr/bin/env bash

echo "Terraform AWS Web Architecture Setup"
echo
echo "This script will create a terraform.tfvars file with your configuration."
echo

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

read -p "Link to Public Git repo to be cloned (default: rlpvin/hello-world-page): " GIT_REPO
GIT_REPO=${GIT_REPO:-https://github.com/rlpvin/hello-world-page.git}

cat > terraform.tfvars << EOF
project_name = "$project_name"
aws_access_key = "$aws_access_key"
aws_secret_key = "$aws_secret_key"
aws_region     = "$aws_region"
GIT_REPO        = "$GIT_REPO"
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
