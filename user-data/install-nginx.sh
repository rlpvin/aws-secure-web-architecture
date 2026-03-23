#!/bin/bash
set -e

exec > /var/log/user-data.log 2>&1

GIT_REPO="${GIT_REPO}"
BUCKET_NAME="${BUCKET_NAME}"

yum update -y
yum install -y nginx git

systemctl start nginx
systemctl enable nginx

if [[ -n "$GIT_REPO" ]]; then
    rm -rf /usr/share/nginx/html/*
    
    git clone $GIT_REPO /usr/share/nginx/html/

    # Initial upload to S3
    if [[ -n "$BUCKET_NAME" ]]; then
        aws s3 cp /usr/share/nginx/html/index.html s3://$BUCKET_NAME/static/index.html
        aws s3 cp /usr/share/nginx/html/style.css s3://$BUCKET_NAME/static/style.css
    fi

    CRON_JOB="0 0 * * * root cd /usr/share/nginx/html && /usr/bin/git pull && /usr/bin/aws s3 sync . s3://$BUCKET_NAME/static/ --exclude '*' --include 'index.html' --include 'style.css' >> /var/log/site-sync.log 2>&1"
    echo "$CRON_JOB" > /etc/cron.d/site-update
    chmod 644 /etc/cron.d/site-update

    systemctl restart crond
    systemctl enable crond
else
    echo "<h1>Hello World from Terraform Auto Scaling Group</h1>" > /usr/share/nginx/html/index.html
fi
