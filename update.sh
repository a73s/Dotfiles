# !/bin/bash
echo "Updating system..."
sudo dnf update
echo "Updating Flatpaks..."
flatpak update
