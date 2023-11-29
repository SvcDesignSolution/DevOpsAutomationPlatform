#!/bin/bash

sudo apt install jq ansible -y

mkdir -pv ~/.ssh/
cat > ~/.ssh/id_rsa << EOF
${{ secrets.SSH_PRIVATE_KEY }}
EOF
sudo chmod 0400 ~/.ssh/id_rsa
md5sum ~/.ssh/id_rsa

mkdir -pv hosts/
cat > hosts/inventory << EOF
[master]
${{ secrets.HOST_DOMAIN }}               ansible_host=${{ secrets.HOST_IP }}

[all:vars]
ansible_port=22
ansible_ssh_user=${{ secrets.HOST_USER }}
ansible_ssh_private_key_file=~/.ssh/id_rsa
ansible_host_key_checking=False
ingress_ip=${{ secrets.HOST_IP }}
dns_ak=$DNS_AK
dns_sk=$DNS_SK
oss_ak=$OSS_AK
oss_sk=$OSS_SK
admin_password=$ROOT_PASSWORD
smtp_password=$SMTP_PASSWORD
gitlab_oidc_client_token=$GITLAB_OIDC_CLIENT_TOKEN
harbor_oidc_client_token=$HARBOR_OIDC_CLIENT_TOKEN
EOF
