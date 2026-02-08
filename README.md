# Wazuh-Docker Test Lab
![wazuh_lab drawio](https://github.com/user-attachments/assets/31d0e625-ac85-40ed-afba-5510595d3093)
## About setup
Script I added works on wazuh vx.x and I tested it on Ubuntu 24.04.

If there is new version release, then follow Wazuh [docs for Docker](https://documentation.wazuh.com/current/deployment-options/docker/wazuh-container.html)

For client OS I tested it on Windows Server 2019, Debian 13, OpenSUSE Leap 16 (raw agent installation).
Raw agent installation chosen insted of docker because Wazuh Agent has issues with OS definition and naming (and also it's easier to manage raw installation).

## Requirements & General steps
Minimal hardware requirements for Wazuh Server:
- OS: Linux or windows
- Arch: AMD64
- CPU: 4 cores
- RAM: 8GB
- Disk: 50GB

If you process with installation on debian-based distro (with apt package manager), then simply do `./setup.sh`, or you can follow these installation steps:

1. Install docker & docker-compose on your system
2. Set `max_map_count` to 262144 on your Docker host (Linux or WSL2 Environment)
```bash
sysctl -w vm.max_map_count=262144
```
3. Go into `single-node/` and generate certs
```bash
docker compose -f generate-indexer-certs.yml run --rm generator
```
4. Then, finally, run Wazuh compose-file
```bash
docker compose up -d
```
## Best Practices
1. It would've be good to **change passwords** on managements users (these are reserved and cannot be deleted), but you cannot do this during installation, because you need deployed wazuh services with passwords set. Even if you will change it in docker-compose file it will not take effect until you generate hash with special tool and replace it in internal_users.yml

- [Insctruction for password changing](https://documentation.wazuh.com/current/deployment-options/docker/changing-default-password.html#set-a-new-password-in-the-docker-compose-file)

Also, **adding** users is way more convenient through Wazuh Dashboard GUI (Indexer -> Security tab).

2. Observe logs you getting and be ready to lower level of many false positives and increase level fohttps://documentation.wazuh.com/current/user-manual/ruleset/rules/custom.html#changing-existing-rulesr events you want Wazuh to mark as important. By default there are many events of Medium and High severity, that should be rather Critical or Low.

- [Instruction for rules overwriting](https://documentation.wazuh.com/current/user-manual/ruleset/rules/custom.html#changing-existing-rules)

For docker installation it's more convenient to do this through Dashboard.

## Official repo
I took almost all files for setup from official Wazuh repository, so you can use this repo for manager/agent installation.

- https://github.com/wazuh/wazuh-docker.git




