#!/bin/bash

# ------------------
#   Constant Colours
# ------------------
BLUE="\033[0;34m"
NC="\033[0m"

# ----------------
#   Install codecs
# ----------------
echo -e "${BLUE}Installing your codecs${NC}"
sudo dnf -y groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf -y groupupdate sound-and-video
sudo dnf install gstreamer1-{plugin-crystalhd,ffmpeg,plugins-{good,ugly,bad{,-free,-nonfree,-freeworld,-extras}{,-extras}}} libmpg123 lame-libs --setopt=strict=0 -y
sudo dnf install -y gstreamer1-plugin-openh264 gstreamer1-plugins-base gstreamer1-plugins-good gstreamer1-plugins-ugly gstreamer1-plugins-bad-free gstreamer1-plugins-bad-free gstreamer1-plugins-bad-freeworld gstreamer1-plugins-bad-free-extras
echo ""

# ------------------
#   Install packages
# ------------------
echo -e "${BLUE}Installing your dnf packages${NC}"
repo_packages="nodejs npm unzip google-chrome-stable lutris steam code dotnet-sdk-3.1 mono-devel vlc ffmpeg p7zip p7zip-plugins unrar gparted winehq-stable"
sudo dnf install -y $repo_packages
echo ""

# --------------
#   Misc Install
# --------------
echo -e "${BLUE}Misc Install${NC}"
sudo dnf install -y *-firmware
sudo dnf -y groupupdate core
sudo dnf install fedy -y
echo ""

# -------------
#   Install nvm
# -------------
echo -e "${BLUE}Installing nvm${NC}"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
echo ""

# ----------------------------
#   Install packages from snap
# ----------------------------
echo -e "${BLUE}Installing your snap packages${NC}"
sudo snap install mailspring
sudo snap install postman
sudo snap install rider --classic 
echo ""

# -------------------------------
#   Install packages from flathub
# -------------------------------
flatpak install flathub com.discordapp.Discord

# -------------------
#   Install GitKraken
# -------------------
wget https://release.gitkraken.com/linux/gitkraken-amd64.rpm
sudo dnf install ./gitkraken-amd64.rpm

# --------------
#   Set up fonts
# --------------
echo -e "${BLUE}Setting up your fonts${NC}"
if [ $HOME != $PWD ]
then
    echo "Currently in: `pwd`"
    echo "Changing into your Home directory"
    cd $HOME
else
    echo "Currently in: `home`"
fi
echo ""

echo -e "${BLUE}Creating fonts folder${NC}"

if [ -d ".fonts" ]
then
    echo -e "${BLUE}Fonts folder already exists${NC}"
else
    mkdir .fonts
    echo -e "${BLUE}Fonts folder created${NC}"
fi
echo ""

echo -e "${BLUE}Changing into fonts directory${NC}"
cd .fonts
echo -e "${BLUE}Currently in: `pwd`${NC}"
echo ""

echo -e "${BLUE}Downloading Anonymous Pro font${NC}"
curl -O https://www.marksimonson.com/assets/content/fonts/AnonymousPro-1.002.zip
echo -e "${BLUE}Extracting zip file${NC}"
unzip -q -o *.zip
echo -e "${BLUE}Deleting zip file${NC}"
rm *.zip
echo -e "${BLUE}Refreshing font cache${NC}"
sudo fc-cache -f
echo ""

# --------------
#   Install Kite
# --------------
echo -e "${BLUE}Currently in: `pwd`${NC}"
echo -e "${BLUE}Changing into Home directory${NC}"
cd $HOME
echo -e "${BLUE}Currently in: `pwd`${NC}"
echo -e "${BLUE}Running command to install Kite${NC}"
bash -c "$(wget -q -O - https://linux.kite.com/dls/linux/current)"
echo ""

# -----------------------
#   Clone my public repos 
# -----------------------
echo -e "${BLUE}Currently in: `pwd`${NC}"
echo -e "${BLUE}Changing into Desktop directory${NC}"
cd ~/Desktop
echo -e "${BLUE}Currently in: `pwd`${NC}"

git config --global credential.helper store

echo -e "${BLUE}Creating projects folder${NC}"
if [ -d "projects" ]
then
    echo -e "${BLUE}Projects folder already exists${NC}"
else
    mkdir projects
    echo -e "${BLUE}Projects folder created${NC}"
fi

echo -e "${BLUE}Changing into projects directory${NC}"
cd projects
echo -e "${BLUE}Currently in: `pwd`${NC}"

echo -e "${BLUE}Cloning all public repos${NC}"
curl -s https://api.github.com/users/waaiez/repos | grep \"clone_url\" | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g' | xargs -n1 git clone


echo "Reboot your system"