#!/bin/bash

tmp_path="/tmp/ansible/wso2"

echo "Cleaning..."
rm -rf $tmp_path

echo "Testing host reachability..."
ansible test -m ping -i hosts/test.ini --connection=local

echo "Checking syntax...."
ansible-playbook playbooks/wso2ei-6.1.1/ubuntu.yaml --syntax-check -i hosts/test.ini

if [ $? == 0 ]; then
  echo "Running Playbook..."
  ansible-playbook playbooks/wso2ei-6.1.1/ubuntu.yaml --connection=local -i hosts/test.ini

  # TODO: Temp, until running this in ansible is figured out
  echo "Running WSO2 server..."
  pushd $tmp_path/wso2ei-6.1.1/bin > /dev/null 2>&1
    bash business-process.sh
  popd > /dev/null 2>&1
fi
