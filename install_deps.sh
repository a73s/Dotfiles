#!/bin/bash

# Install stuff
sudo dnf copr enable -y solopasha/hyprland
sudo dnf copr enable -y monkeygold/nautilus-open-any-terminal
sudo dnf install -y hyprland fd-find wofi ripgrep nvim hypridle waybar hyprlock alacritty swaybg mako network-manager-applet xfce-polkit gnome-keyring blueman brightnessctl grim slurp wireplumber playerctl xfce-polkit git neovim nextcloud-client nextcloud-client-nautilus pip fish seahorse nautilus-open-any-terminal podman podman-compose
sudo dnf group install c-development
sudo dnf group install container-management

# Set up virtualization
sudo dnf group install -y virtualization
sudo systemctl start libvirtd
sudo systemctl enable libvirtd

# neovim stuff
pip install pynvim
nvim --headless "+Lazy! restore" +qa

# Set up nautilus
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal alacritty

# Install nerd fonts
cd ~/Downloads
# release version should be updated periodically
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CascadiaMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Ubuntu.zip
unzip CascadiaMono.zip -d CascadiaMono
unzip Ubuntu.zip -d Ubuntu
mv CascadiaMono ~/.local/share/fonts/
mv Ubuntu ~/.local/share/fonts/
rm CascadiaMono.zip
rm Ubuntu.zip
cd ~/

# Add some file templates
touch ~/Templates/blank
touch ~/Templates/text.txt
echo "#!/bin/python3" >> ~/Templates/python.py

# Bash config stuff
echo "source ~/bashcfg.sh" >> ~/.bashrc

# Change shell to fish
chsh -s /usr/bin/fish

# Install flatpaks
flatpak install fedora org.keepassxc.KeePassXC -y

# Finally, update and reboot
sudo dnf update -y
sudo systemctl reboot
