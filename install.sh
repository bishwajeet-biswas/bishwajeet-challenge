#!/usr/bin/env bash
set -e 

REPO_URL="https://github.com/swft-blockchain/test-devops-1.git"
REPO_DIR="test-devops-1"

detect_os() {
  case "$OSTYPE" in
    linux*)   OS="linux" ;;
    darwin*)  OS="mac" ;;
    msys*|cygwin*|win32*) OS="windows" ;;
    *)        OS="unknown" ;;
  esac
}

detect_and_install_git() {
    if command -v git &>/dev/null; then
        echo "[INFO] Git is already installed: $(git --version)"
        return
    fi

    echo "warning git not found, attempting installation.."

    if [[ "$OS" == "linux" ]]; then
        sudo apt-get update -y && apt-get install git -y || sudo yum install -y git 

    elif [[ "$OS" == "mac" ]]; then
        if command -v brew &>/dev/null; then
            brew install git 
        else
            echo "homebrew not found"
            exit 1
        fi

    elif [[ "$OS" == "windows" ]]; then
        echo "Install Git for Windows: https://git-scm.com/download/win"
        exit 1

    else 
        echo "unsupoorted OS"
        exit 1

    fi

}

ensure_windows_shell() {
  if [[ "$OS" == "windows" ]]; then
    if [[ -z "$MSYSTEM" && -z "$WSL_DISTRO_NAME" ]]; then
      echo " This script must be run using Git Bash or WSL on Windows."
      exit 1
    fi
  fi
}

main(){
detect_os
detect_and_install_git
ensure_windows_shell
# Step 1: Clone or update the repository
if [ -d "$REPO_DIR/.git" ]; then
    echo "[+] Repository exists. Pulling latest changes..."
    cd "$REPO_DIR" && git pull
else
   
    echo "[+] Cloning repository..."
    git clone "$REPO_URL" "$REPO_DIR"
    cd "$REPO_DIR" || { echo "Failed to enter directory"; exit 1; }
fi



# Step 2: Make scripts executable
echo "[+] Granting execution permissions..."
chmod +x setup.sh start.sh

# Step 3: Run setup.sh
echo "[+] Running setup.sh..."
./setup.sh

echo "Setup is completed"
}

main