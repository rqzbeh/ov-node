#!/bin/bash
set -e

APP_NAME="ov-node"
INSTALL_DIR="/opt/$APP_NAME"
REPO_URL="https://github.com/rqzbeh/ov-node"
PYTHON="/usr/bin/python3"

GREEN="\033[0;32m"
YELLOW="\033[1;33m"
NC="\033[0m"

echo -e "${YELLOW}Updating system...${NC}"
apt update -y
apt install -y python3 python3-full python3-venv wget curl git

echo -e "${YELLOW}Installing uv...${NC}"
curl -LsSf https://astral.sh/uv/install.sh | sh

export PATH="$HOME/.local/bin:$PATH"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

if ! command -v uv &> /dev/null; then
    echo -e "${YELLOW}uv not found in PATH, trying alternative installation...${NC}"
    wget -qO- https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
fi

# Download repo
if [ ! -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}Cloning repository...${NC}"
    git clone "$REPO_URL" "$INSTALL_DIR"
else
    echo -e "${GREEN}Directory exists, updating...${NC}"
    cd "$INSTALL_DIR"
    git pull
fi

cd "$INSTALL_DIR"

echo -e "${YELLOW}Installing dependencies...${NC}"
uv sync

uv run python installer.py