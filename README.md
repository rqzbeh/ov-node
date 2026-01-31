<h1 align="center">OV-Node</h1>

<p align="center">
  <strong>OpenVPN backend manager for <a href="https://github.com/primeZdev/ov-panel">OV-Panel</a></strong>
</p>

---

## 📋 Table of Contents

- [Features](#-features)
- [Requirements](#-requirements)
- [Installation](#-installation)
- [Usage](#-usage)
- [Configuration](#-configuration)
- [Troubleshooting](#-troubleshooting)
- [License](#-license)

---

## ✨ Features

- **Automatic Installation**: One-line installation script for quick setup
- **OpenVPN Integration**: Automatic OpenVPN server installation and configuration
- **Systemd Service**: Runs as a background service with auto-restart
- **Easy Management**: Interactive menu for install, update, restart, and uninstall
- **API Integration**: RESTful API for remote management via OV-Panel
- **Client Configuration**: Automatic client-config-dir setup for per-client routing

---

## 🔧 Requirements

### System Requirements
- **OS**: Ubuntu 20.04/22.04, Debian 10/11, or other Debian-based Linux distributions
- **Architecture**: x86_64 (amd64)
- **RAM**: Minimum 512MB (1GB+ recommended)
- **Disk Space**: At least 2GB free space
- **Root Access**: Required for installation

### Network Requirements
- **Public IP Address**: Required for VPN server
- **Open Ports**: 
  - Port 1194 (UDP) - OpenVPN default port
  - Port 9090 (TCP) - OV-Node API port (configurable)

---

## 🚀 Installation

### Quick Install (Recommended)

Run the following command as root on your Linux VPS:

```bash
curl -fsSL https://raw.githubusercontent.com/rqzbeh/ov-node/main/install.sh | bash
```

Or using wget:

```bash
wget -qO- https://raw.githubusercontent.com/rqzbeh/ov-node/main/install.sh | bash
```

### What the installer does:

1. Updates system packages
2. Installs required dependencies (Python 3, git, wget, curl)
3. Installs `uv` package manager
4. Clones the latest OV-Node code from GitHub
5. Installs Python dependencies
6. Launches the interactive installer menu

### Interactive Installation

After running the installation script, you'll see an interactive menu:

```
==================================
Welcome to the OV-Node Installer
==================================

Please choose an option:

  1. Install
  2. Update
  3. Restart
  4. Uninstall
  5. Exit

Enter your choice:
```

**Choose Option 1 (Install)** to begin the installation process.

#### Installation Steps:

1. **OpenVPN Configuration**: The installer will automatically configure OpenVPN with sensible defaults:
   - IPv4 address selection
   - UDP protocol (recommended for VPN)
   - Port 1194
   - DNS server (Google DNS by default)

2. **OV-Node Configuration**: You'll be prompted for:
   - **Service Port**: Default is 9090 (press Enter to use default)
   - **API Key**: A unique identifier for panel connection (auto-generated UUID provided as example)

3. **Service Setup**: The installer will:
   - Create systemd service
   - Enable auto-start on boot
   - Start the OV-Node service

---

## 📖 Usage

### Access the Installer Menu

To access the installer menu at any time:

```bash
cd /opt/ov-node
uv run python installer.py
```

### Menu Options

#### 1. Install
- Installs OpenVPN server and OV-Node
- Configures systemd service
- Only available if not already installed

#### 2. Update
- Pulls the latest changes from the repository
- Preserves your `.env` configuration
- Reinstalls dependencies
- Restarts the service

#### 3. Restart
- Restarts both OV-Node and OpenVPN services
- Useful after configuration changes

#### 4. Uninstall
- Removes OpenVPN server
- Removes OV-Node installation
- Stops and disables services

#### 5. Exit
- Exits the installer menu

### Check Service Status

```bash
# Check OV-Node service status
systemctl status ov-node

# Check OpenVPN service status
systemctl status openvpn-server@server

# View OV-Node logs
journalctl -u ov-node -f
```

### Manual Service Control

```bash
# Start services
systemctl start ov-node
systemctl start openvpn-server@server

# Stop services
systemctl stop ov-node
systemctl stop openvpn-server@server

# Restart services
systemctl restart ov-node
systemctl restart openvpn-server@server
```

---

## ⚙️ Configuration

### Environment Variables

Configuration is stored in `/opt/ov-node/.env`:

```bash
# Service port for the OV-Node API
SERVICE_PORT = 9090

# API key for connecting the panel to the node
API_KEY = your_api_key_here

# Optional: Enable development mode
# DOC = True
# DEBUG = INFO
```

### Edit Configuration

```bash
# Edit configuration file
nano /opt/ov-node/.env

# Restart service to apply changes
systemctl restart ov-node
```

### OpenVPN Configuration

OpenVPN configuration is located at:
- Main config: `/etc/openvpn/server/server.conf`
- Client configs: `/etc/openvpn/ccd/`

---

## 🔍 Troubleshooting

### Installation Issues

**Problem**: Installer hangs on "Please wait..." screen

**Solution**: This issue has been fixed in the latest version. Update your installation:
```bash
cd /opt/ov-node
git pull
uv run python installer.py
```

**Problem**: `uv: command not found`

**Solution**: Ensure uv is installed and in your PATH:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"
```

**Problem**: Permission denied errors

**Solution**: Ensure you're running as root:
```bash
sudo su
```

### Service Issues

**Problem**: OV-Node service won't start

**Solution**: Check logs for errors:
```bash
journalctl -u ov-node -n 50 --no-pager
```

**Problem**: Cannot connect to OV-Node API

**Solution**: 
1. Check if service is running: `systemctl status ov-node`
2. Verify port is open: `netstat -tulpn | grep 9090`
3. Check firewall rules: `ufw status`

### OpenVPN Issues

**Problem**: OpenVPN service failed to start

**Solution**: Check OpenVPN logs:
```bash
journalctl -u openvpn-server@server -n 50 --no-pager
```

**Problem**: Clients can't connect

**Solution**:
1. Verify OpenVPN is listening: `netstat -tulpn | grep 1194`
2. Check firewall allows UDP 1194: `ufw allow 1194/udp`
3. Verify client configuration file is correct

### Getting Help

If you encounter issues:
1. Check the logs: `journalctl -u ov-node -f`
2. Verify all services are running
3. Check the [Issues](https://github.com/rqzbeh/ov-node/issues) page
4. Create a new issue with detailed error logs

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- [Nyr's OpenVPN installer](https://github.com/Nyr/openvpn-install) - For the excellent OpenVPN installation script
- [OV-Panel](https://github.com/primeZdev/ov-panel) - The frontend panel this backend is designed for

---

<p align="center">Made with ❤️ for the OV-Panel ecosystem</p>
