#!/bin/bash

GROUP=${1:-all}

if [ $GROUP -ne 'all' ]; then
  ansible-playbook -i ./config/inventory.yml -l "$GROUP" ./main.yml -K  
else
  ansible-playbook -i ./config/inventory.yml ./main.yml -K
fi