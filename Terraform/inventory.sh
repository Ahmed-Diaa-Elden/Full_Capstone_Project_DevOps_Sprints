#!/bin/bash

# Define the replacement line
replacement_line="app-1 ansible_host=${1} ansible_user=ubuntu ansible_ssh_private_key_file=./Sprints-Key-pair.pem ansible_ssh_common_args=\"-o StrictHostKeyChecking=no\""

# Specify the file to edit
file="../inventory.ini"

# Use sed to edit the file
sed -i "/^app-1/c\\$replacement_line" "$file"
