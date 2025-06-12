#!/bin/bash

# ================================
# Terminal colours
# ================================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Colour

# ================================
# Error handling
# ================================
function func_errors_handling(){
    local status=$?
    if [ $status -ne 0 ]; then
        echo -e "${RED}❌ Error (exit code $status) in function: ${FUNCNAME[1]}${NC}" >&2
        exit $status
    fi
}

# ================================
# Update the system
# ================================
function func_os_update(){
    echo -e "${YELLOW}➤ Updating system packages...${NC}"
    sudo apt-get update
    func_errors_handling
}

# ================================
# Install required components
# ================================
function func_install_components(){
    echo -e "${YELLOW}➤ Installing required components...${NC}"
    sudo apt-get install -y \
        ca-certificates \
        curl \
        gnupg
    func_errors_handling
}

# ================================
# Add Docker GPG key
# ================================
function func_ad_docker_key(){
    echo -e "${YELLOW}➤ Adding Docker GPG key...${NC}"
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | \
        sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    func_errors_handling
}

# ================================
# Add Docker repository
# ================================
function func_add_docker_repo(){
    echo -e "${YELLOW}➤ Adding Docker repository...${NC}"
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    func_errors_handling
}

# ================================
# Install Docker Engine
# ================================
function func_install_docker_engine(){
    echo -e "${YELLOW}➤ Installing Docker Engine...${NC}"
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    func_errors_handling
}

# ================================
# Run installation steps
# ================================
echo -e "${GREEN}🚀 Starting Docker installation...${NC}"

func_os_update
func_install_components
func_ad_docker_key
func_add_docker_repo
func_install_docker_engine

echo -e "${GREEN}✅ Done! Docker has been successfully installed.${NC}"
