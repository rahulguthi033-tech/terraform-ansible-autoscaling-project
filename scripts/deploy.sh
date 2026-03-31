#!/bin/bash

echo "===== Terraform Init ====="
cd ../terraform
terraform init

echo "===== Terraform Apply ====="
terraform apply -auto-approve

echo "===== Get PRIVATE IPs from ASG ====="
aws ec2 describe-instances \
--filters "Name=tag:Name,Values=web-server" "Name=instance-state-name,Values=running" \
--query 'Reservations[*].Instances[*].PrivateIpAddress' \
--output text > ../ansible/inventory

echo "===== Update Inventory ====="
cd ../ansible

sed -i '1i [web]' inventory

echo "ansible_user=ubuntu" >> inventory
echo "ansible_ssh_private_key_file=~/your-key.pem" >> inventory

# Optional: Bastion (recommended)
echo "ansible_ssh_common_args='-o ProxyCommand=\"ssh -i ~/your-key.pem ubuntu@BASTION_PUBLIC_IP -W %h:%p\"'" >> inventory

echo "===== Run Ansible Playbook ====="
ansible-playbook -i inventory playbook.yml

echo "===== Deployment Completed ====="
