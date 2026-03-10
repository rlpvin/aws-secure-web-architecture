#!/bin/bash
set -e

exec > /var/log/user-data.log 2>&1

GIT_REPO="${GIT_REPO}"

yum update -y
yum install -y nginx git

systemctl start nginx
systemctl enable nginx

if [[ -n "$GIT_REPO" ]]; then
    rm -rf /usr/share/nginx/html/*
    
    git clone $GIT_REPO /usr/share/nginx/html/

    CRON_JOB="0 0 * * * root cd /usr/share/nginx/html && /usr/bin/git pull >> /var/log/git-pull.log 2>&1"
    echo "$CRON_JOB" > /etc/cron.d/site-update
    chmod 644 /etc/cron.d/site-update

    systemctl restart crond
    systemctl enable crond
else
    echo "<h1>Hello World from Terraform Auto Scaling Group</h1>" > /usr/share/nginx/html/index.html
fi
