# vaclab-local
A local vaclab clone based on Rancher Desktop.
This repository helps you build a functional single-node cluster clone of the original vaclab environment with monitoring, logging, and other required components exposed through local ingresses.

## Project Status

| Feature/Component                       | Status  |
|-----------------------------------------|---------|
| Original vaclab VictoriaMetrics setup   | ✅ OK   |
| Original vaclab VictoriaLogs setup      | ✅ OK   |
| Grafana clone                          | ✅ OK   |
| Ingress (no port forwarding)            | ✅ OK   |
| Self-Signed Certs (HTTPS)               | ❌ Not yet   |
| Tested on Linux                        | ✅ OK   |
| Tested on Mac                          | ❌ Not yet  |
| External/P2P access (from other laptop)      | ❌ Not yet |
| Windows support                        | ❌ Not yet |
| Documentation completeness              | ⚠️ Partial |

## Local Domains

For easy access, all services are exposed via **localtest.me** using ingress (no TLS used for now, everything is exposed through http)

- Grafana at: [http://grafana.localtest.me](http://grafana.localtest.me)
- VictoriaLogs at: [http://vselect.localtest.me](http://vlselect.localtest.me/select/vmui/)

## Architecture

- **Kubernetes (Rancher Desktop):** Local single-node K3S cluster
- **Traefik:** Ingress controller for local domains (e.g., `grafana.localtest.me` and `vselect.localtest.me`)
- **VictoriaMetrics:** Metrics monitoring stack
- **VictoriaLogs:** Centralized log management
- **Grafana:** Dashboards for metrics and logs

---

## 📦 Prerequisites

- [Rancher Desktop](https://rancherdesktop.io/) (latest)
- OS: Linux (Debian recommended) or macOS
- **Linux only:** To allow Traefik to bind to port 80:
  1. Copy the provided sysctl config file:
     ```bash
     sudo cp 99-vaclab.sysctl.conf /etc/sysctl.d/
     ```
  2. Apply the new sysctl settings:
     ```bash
     sudo sysctl --system
     ```
  > By default, Linux restricts binding to ports <1024 to root. The sysctl config sets `net.ipv4.ip_unprivileged_port_start=80`, allowing Traefik (running as non-root in Kubernetes) to listen on port 80. This step is not required on macOS or Windows.

## 🖥️ Rancher Desktop Setup

1. **Install Rancher Desktop**
   - Follow the official instructions for your platform: [Rancher Desktop Installation Guide](https://docs.rancherdesktop.io/getting-started/installation/#installation-via-deb-package)
   > **Note:** Rancher Desktop provides `kubectl` and `helm` binaries in `~/.rd/bin/`. You do not need to install them separately.
2. **First Launch:**
   - Enable Kubernetes in the Rancher Desktop UI.
   - Choose either Docker or containerd as your container runtime (both are valid).
3. **Environment Setup:**
   - After enabling Kubernetes, ensure your shell exports the Rancher Desktop binaries:
     ```bash
     source ~/.bashrc
     # Or for zsh:
     source ~/.zshrc
     ```
   - Confirm `kubectl` and `helm` are available:
     ```bash
     which kubectl
     which helm
     # Should show ~/.rd/bin/kubectl and ~/.rd/bin/helm
     ```

## 🚀 Quick Start

1. **Review and edit values files if needed (optional):**
   - `vmetrics.values.yaml` (VictoriaMetrics monitoring stack)
   - `vlogs.values.yaml` (VictoriaLogs stack)
2. **Run the setup script:**
   ```bash
   ./setup.sh
   ```
   > **Note:** Run as a regular user (not with `sudo`)


## 🛠️ Troubleshooting

- If you see permission errors, ensure you run the script as a regular user.
- If `kubectl` or `helm` are not found, make sure Rancher Desktop is installed, Kubernetes is enabled, and your shell is sourced.

## 🤝 Contributing

Contributions are welcome! Please open issues or pull requests for improvements, bug fixes, or new features.

## 💬 Support

For questions or help, open an issue or contact the maintainers via GitHub or Discord.
