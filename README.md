# vaclab-local
A local vaclab clone based on rancher desktop.

This repository helps you build a functional single-node cluster clone of the original vaclab environment with monitoring, logging, and other required components exposed through local ingresses.

---

## 📦 Prerequisites

### 1. Install Latest Rancher Desktop

#### Linux Debian
```bash
curl -s https://download.opensuse.org/repositories/isv:/Rancher:/stable/deb/Release.key | gpg --dearmor | sudo dd status=none of=/usr/share/keyrings/isv-rancher-stable-archive-keyring.gpg
echo 'deb [signed-by=/usr/share/keyrings/isv-rancher-stable-archive-keyring.gpg] https://download.opensuse.org/repositories/isv:/Rancher:/stable/deb/ ./' | sudo dd status=none of=/etc/apt/sources.list.d/isv-rancher-stable.list
sudo apt update
sudo apt install rancher-desktop 
```
