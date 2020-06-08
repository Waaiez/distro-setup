#!/bin/bash

# ------------------
#   Constant Colours
# ------------------
BLUE="\033[0;34m"
NC="\033[0m"

#echo -e "${BLUE}${NC}"

# ---------------------
#   Update any packages
# ---------------------
echo -e "${BLUE}Updating any packages${NC}"
sudo pacman -Syu --noconfirm
echo ""

# ----------------------
#   Install any packages
# ----------------------
echo -e "${BLUE}Installing your packages${NC}"
local packages="discord nodejs npm nvm yay"
pacman -Sy --noconfirm $packages
echo ""

# -------------------------
#   Update any  aur package
# -------------------------
echo -e "${BLUE}Updating any aur packages${NC}"
sudo yay -Syu
echo ""

# ----------------------
#   Install aur packages
# ----------------------
echo -e "${BLUE}Installing your aur packages${NC}"
local aurpackages="firefox-beta-bin gitkraken google-chrome mailspring postman-bin spotify spotify-adblock-linux trilium-bin visual-studio-code-bin"
yay -S --noconfirm $aurpackages
echo ""

# ------------------
#   Setting up fonts
# ------------------
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
echo -e "${BLUE}Running command to install Kite${NC}"
bash -c "$(wget -q -O - https://linux.kite.com/dls/linux/current)"
echo ""

# ---------------------------
#   Install VSCode extensions
# ---------------------------
echo -e "${BLUE}Installing Visual Studio Code extensions${NC}"
while read line; do code --install-extension "$line";done < vscode-extensions.txt
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
