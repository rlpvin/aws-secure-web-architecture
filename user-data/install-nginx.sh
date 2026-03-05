#!/bin/bash

yum update -y
yum install nginx -y

systemctl start nginx
systemctl enable nginx

echo "<h1>Hello World from Terraform Auto Scaling Group</h1>" > /usr/share/nginx/html/index.html
