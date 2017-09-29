#!/bin/bash

tmp_path="/tmp/ansible/wso2"

echo "Cleaning..."
rm -rf $tmp_path

echo "Testing host reachability..."
ansible test -m ping -i hosts/test.ini --connection=local

echo "Checking syntax...."
ansible-playbook wso2ei-6.1.1/playbooks/ubuntu.yaml --syntax-check -i hosts/test.ini --connection=local

if [ $? == 0 ]; then
  echo "Running Playbook..."
  ansible-playbook wso2ei-6.1.1/playbooks/ubuntu.yaml --connection=local -i hosts/test.ini --connection=local
fi
