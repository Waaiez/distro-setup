#!/bin/bash

# ------------------
#   Constant Colours
# ------------------
BLUE="\033[0;34m"
NC="\033[0m"

# --------------------------
#   Update existing packages
# --------------------------
echo -e "${BLUE}Updating any packages${NC}"
sudo dnf -y update
sudo dnf -y upgrade
echo ""

# --------------
#   Enable snaps
# --------------
echo -e "${BLUE}Enabling snaps${NC}"
sudo dnf install -y snapd
sudo ln -s /var/lib/snapd/snap /snap
echo ""

# ----------------
#   Enable flatpak
# ----------------
echo -e "${BLUE}Enabling flatpak${NC}"
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo ""

# ------------------------
#   Enable RPM Fusion repo
# ------------------------
echo -e "${BLUE}Enable RPM Fusion repo${NC}"
echo -e "${BLUE}Enable Free RPM Fusion repo${NC}"
sudo rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
echo -e "${BLUE}Enable Non-Free RPM Fusion repo${NC}"
sudo rpm -Uvh http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
echo -e "${BLUE}Enable Free Tainted RPM Fusion repo${NC}"
sudo dnf install -y rpmfusion-free-release-tainted
echo -e "${BLUE}Enable Non-Free Tainted RPM Fusion repo${NC}"
sudo dnf install -y rpmfusion-nonfree-release-tainted
echo ""

# ------------------------
#   Enable Microsoft repo
# ------------------------
echo -e "${BLUE}Enable Microsoft repo${NC}"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
echo ""

# --------------------------------------------
#   Enable DeltaRPM and Fastest Mirror Plugins
# --------------------------------------------
echo -e "${BLUE}Enable DeltaRPM and Fastest Mirror Plugins${NC}"
sudo chmod 644 /etc/dnf/dnf.conf
echo "fastestmirror=true" | sudo tee -a /etc/dnf/dnf.conf
echo "deltarpm=true" | sudo tee -a /etc/dnf/dnf.conf
echo ""

# ------------------
#   Enable Mono repo
# ------------------
echo -e "${BLUE}Enable Mono repo${NC}"
sudo rpm --import "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
sudo sh -c 'curl https://download.mono-project.com/repo/centos8-stable.repo | tee /etc/yum.repos.d/mono-centos8-stable.repo'
echo ""

# ------------------
#   Reduce Battery Usage
# ------------------
echo -e "${BLUE}Reduce Battery Usage${NC}"
sudo dnf install -y tlp tlp-rdw
sudo systemctl enable tlp
echo ""

# ------------------
#   Enable open264 repo
# ------------------
echo -e "${BLUE}Enable open264 repo${NC}"
sudo dnf config-manager --set-enabled fedora-cisco-openh264
echo ""

# --------------------------
#   Enable better fonts
# --------------------------
echo -e "${BLUE}Enable better fonts${NC}"
sudo dnf copr enable dawid/better_fonts -y
sudo dnf install -y fontconfig-enhanced-defaults fontconfig-font-replacements
echo ""

# ---------------------------------
#   Enable Fedora Workstation Repos
# ---------------------------------
echo -e "${BLUE}Enable Fedora Workstation Repos${NC}"
sudo dnf install fedora-workstation-repositories
echo ""

# --------------------------------
#   Enable Google Chrome installer
# --------------------------------
echo -e "${BLUE}Enable Google Chrome installer${NC}"
sudo dnf config-manager --set-enabled google-chrome
echo ""

# -------------
#   Enable Misc
# -------------
sudo dnf copr enable kwizart/fedy
sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/33/winehq.repo

# --------------------------
#   Update existing packages
# --------------------------
echo -e "${BLUE}Updating any packages${NC}"
sudo dnf update -y
sudo dnf upgrade -y
echo ""

echo "Reboot your system"
