# AnsiblePlaybook_yuriko_co_nz
Ansible playbook &amp; server config of yuriko.co.nz with SElinux

ぼくのかんがえたさいきょうのサーバ設定！ with SELinux [(構築ポリシー)](server-migration/Summary.md)

# Overview

## Layer
| Layer                | Managed by |
| -------------------- | ---------- |
| Container            | |
| Docker               | |
| CentOS 7             | |
| QEMU Guest           | ConoHa     |
| QEMU Host(OpenStack) | ConoHa     |
| Physical Server      | ConoHa     |

QEMU Guest and Host are provided by ConoHa VPS (IaaS)

This playbook will target above CentOS Layer

### QEMU Guest
[ConoHa](https://www.conoha.jp/conoha/) 1GB server plan (880 Yen/month)

* CPU: 1 core 2 threads
* Memory: 1GB Physical + 8GB Swap
* Storage: 100GB SSD

### Server OS
Use CentOS (Minimal install from iso image).

ConoHa official CentOS image was not used. (It doesn't contains LVM partition for snapshot backup)

Enables IPv6 & SELinux

root Filesystem is ext4 on LVM -> [Filesystem Layout](tasks/filesystem.yml)

### Docker containers

Containers are managed by docker-compose

* Nginx + certbot
* php-fpm
* MediaWiki
* PostgreSQL
* IPsec/L2TP
* BOINC
* OpenVPN
* [Mailu](https://github.com/Mailu/Mailu) (Postfix/dovecot/clamav etc...)

## DNS
Use ConoHa's Managed DNS service. (FREE!)

# Future Improvement Plan
See [Issue](https://github.com/IchikawaYukko/AnsiblePlaybook_yuriko_co_nz/issues)

Ideas are welcome!
