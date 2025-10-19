#!/bin/bash

# Usage: ./deep_uninstall_docker.sh [--safe] [--dry-run] [--log]

MODE="full"  # default mode is full cleanup
LOGGING=false
LOGFILE="docker_uninstall.log"

# Parse flags
for arg in "$@"; do
  case $arg in
    --safe) MODE="safe" ;;
    --dry-run) MODE="dry-run" ;;
    --log) LOGGING=true ;;
  esac
done

# Logging helper
log() {
  echo "$1"
  if $LOGGING; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> "$LOGFILE"
  fi
}

# Dry-run wrapper
run_cmd() {
  if [ "$MODE" == "dry-run" ]; then
    log "🔎 DRY-RUN: $*"
  else
    log "🧹 EXEC: $*"
    eval "$@"
  fi
}

log "🚨 Starting deep Docker uninstall (mode: $MODE)..."

# Stop services
run_cmd "sudo systemctl stop docker"
run_cmd "sudo systemctl disable docker"
run_cmd "sudo systemctl stop containerd"
run_cmd "sudo systemctl disable containerd"

# Remove packages
run_cmd "sudo apt remove -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker.io"
[ "$MODE" == "full" ] && run_cmd "sudo apt purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker.io"
run_cmd "sudo apt autoremove -y"

# Remove repo and GPG key
run_cmd "sudo rm -f /etc/apt/sources.list.d/docker.list"
run_cmd "sudo rm -f /etc/apt/keyrings/docker.gpg"

# Remove binaries
run_cmd "sudo rm -f /usr/bin/docker /usr/local/bin/docker"

# Remove system directories
[ "$MODE" == "full" ] && run_cmd "sudo rm -rf /var/lib/docker /var/lib/containerd /etc/docker /run/docker /var/run/docker.sock"

# Remove user-level configs
run_cmd "rm -rf ~/.docker ~/.config/docker ~/.local/share/docker"

# Remove docker group
run_cmd "sudo gpasswd -d $USER docker"
run_cmd "sudo groupdel docker 2>/dev/null"

# Clean shell aliases
run_cmd "sed -i '/alias docker=/d' ~/.bashrc ~/.zshrc ~/.profile"
run_cmd "sed -i '/docker\/bin/d' ~/.bashrc ~/.zshrc ~/.profile"

log "✅ Docker uninstall complete."

if [ "$MODE" == "dry-run" ]; then
  log "🧪 DRY-RUN mode: No changes were made."
fi
