#!/bin/bash

ansible-playbook -i ./config/inventory.yml ./main.yml -K

# run only against the dns group
# ansible-playbook -i ./config/inventory.yml -l dns ./main.yml -K