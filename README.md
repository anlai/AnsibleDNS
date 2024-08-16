# Ansible DNS

Ansible playbook to manage custom sub-domains across my private network.  The addresses registered are only available within the private network and not setup for use in the public internet.  It still requires to have a registered domain in order for Let's Encrypt certificates to be issued.

## Features

- Build and configure custom dns entries with PiHole (I use Raspberry Pis)
- Install and configure a Docker instance of Traefik
  - Setup Traefik for reverse proxy
  - Setup to request Let's Encrypt certificates
- Write Traefik config only and network copy file (hosts that do not allow docker management, ex. Unraid)
- Single mapping file for DNS and reverse proxy configuration

## Requirements

- 1 (or more) Raspberry Pi, given static ip addresses
- Purchased domain name
- Cloudflare configured as DNS for domain name
- Host setup to run Ansible (e.g. WSL Container)
  - My configuration has a WSL container using certificate authentication to hosts

## Setup

1. Execute `ansible-galaxy install -r ./requirements.yml`
2. Create configuration files: secrets.yml, mapping.hml, inventory.yml (see [Configuration Files](#Configuration-Files))
3. To run against all hosts, you can use `./run.sh` as is, there is also another commented example to run on dns servers only

### Configuration Files

Here is an brief description of the configuration files, once filled out place the files in a folder named `config`.  You can seperate the management of your config files by putting them in a separate repository and cloning into the config folder.

**inventory.yml**

The inventory file contains the necessary information to connect to your hosts (e.g. dns server, docker hosts).

There are three host groups:
- dns: pi-hole dns servers
- docker: docker hosts that can have Traefik installed
- unmanaged: unmanaged docker hosts which must have Traefik preinstalled

The vars defined for each host group are settings that tell the playbook what needs to be done with each host.  The changes that need to be made is adding your hosts, updating ansible_user, and in the case of unmanaged hosts the data_root which is where Traefik configuration files will be copied to.

[see example file](./examples/inventory.yml)

**mapping.yml**

The mapping file maps dns names to hosts and which port to use for reverse proxy.

There are two main properties:
- servers: dictionary of hosts and their IP address
- dns: array of dns names, ip mapping, and port

[see example file](./examples/mapping.yml)

**secrets.yml**

The secrets file contains your secrets for pihole admin screen, cloud flare, and your domain name.

[see example file](./examples/secrets.yml)