# Pre-requisites

* Linux Mint

# Steps
1. Install git `sudo apt install git -y`
2. Import SSH Key to github
```sh
echo "Create ssh key"
ssh-keygen -t ed25519 -C "kim.ae09@gmail.com"
echo "Copy the pub key and place on git tool"
echo "--------------------------------------"
cat $HOME/.ssh/id_ed25519.pub 
echo "--------------------------------------"
```
3. Execute `export $(grep -v '^#' configs/version.env | xargs) && export $(grep -v '^#' configs .custom.envs | xargs) && scripts/bootstrap.sh`

---

# Scripts

## `bootstrap.sh`
Main setup script that initializes the Linux environment with essential tools and configurations:
- Updates system packages and installs Snap
- Downloads and installs Nerd Fonts (RobotoMono)
- Configures Cinnamon desktop settings from config file
- Installs and configures Zsh with Oh My Zsh
- Sets up Powerlevel10k and Oh My Posh themes
- Installs core applications: VS Code, Vim, Google Chrome
- Installs utilities: jq, Flatpak

**Usage:** `./scripts/bootstrap.sh`

## `clone-repos.sh`
Clones personal knowledge base repositories from GitHub:
- `pergaminhos` - Main knowledge base repository
- `.pergaminhos` - Private/hidden knowledge base repository

**Prerequisites:** SSH key must be configured with GitHub access

**Usage:** `./scripts/clone-repos.sh`

## `install-cloud.sh`
Installs cloud platform CLI tools and infrastructure management utilities:
- Azure CLI and AKS CLI for Azure management
- Google Cloud CLI for GCP operations
- Terraform for infrastructure as code

**Usage:** `./scripts/install-cloud.sh`

## `install-dev.sh`
Sets up development environment managers and programming language tools:
- SDKMAN for Java/JVM development tools
- NVM (Node Version Manager) for Node.js
- Rust toolchain via rustup

**Usage:** `./scripts/install-dev.sh`

## `install-k8s.sh`
Comprehensive Kubernetes development environment setup:
- kubectl for Kubernetes cluster management
- Krew plugin manager for kubectl
- Docker Engine and Docker Compose
- Minikube for local Kubernetes clusters
- Build tools (gcc, build-essential)

**Usage:** `./scripts/install-k8s.sh`

## `install-tools.sh`
Installs communication and networking tools:
- Tailscale for VPN and secure networking
- Slack for team communication

**Usage:** `./scripts/install-tools.sh`

