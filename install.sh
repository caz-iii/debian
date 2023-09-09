#!/bin/bash

# APT
echo "-----INSTALLING APT PACKAGES-----"
sudo apt install -y \
    arandr \
    awesome \
    curl \
    flameshot \
    git \
    gimp \
    hugo \
    kitty \
    mpv \
    neofetch \
    newsboat \
    ranger \
    rofi \
    stow \
    vim \
    wget \
    xinit \
    zsh    

# Brave
echo "getting brave..."

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update

sudo apt install -y brave-browser 

# LibreWolf
sudo apt update && sudo apt install -y wget gnupg lsb-release apt-transport-https ca-certificates

distro=$(if echo " una bookworm vanessa focal jammy bullseye vera uma " | grep -q " $(lsb_release -sc) "; then echo $(lsb_release -sc); else echo focal; fi)

wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg

sudo tee /etc/apt/sources.list.d/librewolf.sources << EOF > /dev/null
Types: deb
URIs: https://deb.librewolf.net
Suites: $distro
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/librewolf.gpg
EOF

sudo apt update

sudo apt install -y librewolf 


# Codium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list

sudo apt update && sudo apt install -y codium

# DEB Packages
echo "-----INSTALLING DEB PACKAGES-----"

# Bitwarden
curl -s https://api.github.com/repos/bitwarden/desktop/releases/latest \
    | grep "browser_download_url.*deb" \
    | cut -d : -f 2,3 \
    | tr -d \" \
    | wget -qi -

# MarkText
curl -s https://api.github.com/repos/marktext/marktext/releases/latest \
    | grep "browser_download_url.*deb" \
    | cut -d : -f 2,3 \
    | tr -d \" \
    | wget -qi -

# Obsidian
echo "getting obsidian..."
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.4.5/obsidian_1.4.5_amd64.deb

# OnlyOffice
wget https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb

# Pomotroid
echo "getting pomotroid..."
curl -s https://api.github.com/repos/Splode/pomotroid/releases/latest \
    | grep "browser_download_url.*deb" \
    | cut -d : -f 2,3 \
    | tr -d \" \
    | wget -qi -  

# Install DEB Packages
sudo dpkg -i *.deb

# Meslo Fonts
echo "installing meslo fonts..."
sudo mkdir /usr/share/fonts/meslolgs-nf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
sudo mv MesloLGS* /usr/share/fonts/meslolgs-nf

# Stow Dotfiles
echo "-----SYMBOLICALLY LINK DOTFILES-----"
mkdir ~/flameshots
rm *.deb
stow .

# Powerlevel10k
echo "https://github.com/romkatv/powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# zsh
echo "Switch shell to zsh:"
echo "sudo chsh $USER"
echo "/bin/zsh"  

#git
echo "Git Creds:"
echo "git config --global user.name"
echo "git config --global user.email"
echo "git config --global credential.helper store"
echo "git push or pull"

sudo timedatectl set-local-rtc 1 --adjust-system-clock
