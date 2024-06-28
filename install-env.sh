#!/bin/bash

######################################################################################
## Define Colors and Style Variables
######################################################################################

LB='\n'                     # Line Break

D='\033[36m💎 '             # Title Project      # CYAN
M='\033[0;32m[#]\e[0m'       # Title Module       # GREEN

I='\033[2m[*]\e[0m'         # Minor Information  # CURSIVE
T='\033[94m[÷]\e[0m'        # Major Information  # OKCYAN

E='\033[91m[E]\e[0m'        # Error              # OKBRED
W='\033[93m[!]\e[0m'        # Warning            # OKYELLOW
S='\033[92m[✔]\e[0m'       # Success            # OKGREEN

END='\e[0m'
######################################################################################
## Define Directories
######################################################################################

DIR_HOME=$HOME
DIR_CONFIG=$HOME/.config
DIR_FONTS=$HOME/.local/share/fonts
DIR_ICONS=$HOME/.local/share/icons
DIR_THEMES=$HOME/.local/share/themes
DIR_LIGHTDM=$HOME/.local/share/lightdm
DIR_WALLPAPERS=$HOME/.local/share/wallpapers

######################################################################################
## Define overall appearance
######################################################################################

THEME="Everblush"
THEME_WM="Everblush-xfwm"
ICON="Nordzy-cyan-dark-MOD"
CURSOR="Radioactive-nord"
FONT="Roboto Regular 14"
FONT_MONO="JetBrainsMono Nerd Font Regular 12"

######################################################################################
## Update the system
######################################################################################
echo -e "$LB$D Updating the filesystem...$LB$END"
sudo apt update

######################################################################################
## Install all dependencies beforehand
######################################################################################
echo -e "$LB$D Installing all required packages and dependencies...$LB$END"
######################################################################################

sudo apt install -y libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson cmake libepoxy-dev libxcb-util-dev asciidoc mugshot xfce4-terminal qt5-style-kvantum qt5-style-kvantum-themes xfce4-dev-tools libstartup-notification0-dev libwnck-3-dev libxfce4ui-2-dev libxfce4panel-2.0-dev alsa-utils brightnessctl jq playerctl libkeybinder-3.0-dev i3lock-color neofetch

######################################################################################
## Set up the environment
######################################################################################
echo -e "$LB$D Setting up Environment...$LB$END"
######################################################################################

# Create directories
mkdir -p $DIR_FONTS $DIR_ICONS $DIR_THEMES $DIR_LIGHTDM $DIR_WALLPAPERS

# Generate a backup of the config directory
cp -r $DIR_CONFIG $DIR_CONFIG-backup

#  Configure GENMON Plugin
bash $DIR_BASE/build/genmon.sh
mv genmon-15.rc $DIR_BASE/config/xfce4/panel
mv genmon-16.rc $DIR_BASE/config/xfce4/panel
mv genmon-17.rc $DIR_BASE/config/xfce4/panel

# Copy all required packages
cp -r home/* $DIR_HOME
cp -r config/* $DIR_CONFIG
cp -r fonts/* $DIR_FONTS
cp -r icons/* $DIR_ICONS
cp -r themes/* $DIR_THEMES
cp -r wallpapers/* $DIR_WALLPAPERS

######################################################################################
# Set the GTK+ Theme
######################################################################################
echo -e "$LB$D Setting up GTK+ Theme...$LB$END"
######################################################################################

xfconf-query -c xsettings -p /Net/ThemeName -s $THEME

######################################################################################
## Set the Window Manager Theme
######################################################################################
echo -e "$LB$D Setting up Windows Manager Theme...$LB$END"
######################################################################################

xfconf-query -c xfwm4 -p /general/theme -s $THEME_WM

######################################################################################
# Set the icons
######################################################################################
echo -e "$LB$D Setting up Icons...$LB$END"
######################################################################################
xfconf-query -c xsettings -p /Net/IconThemeName -s $ICON

######################################################################################
## Set the Mouse Theme
######################################################################################
echo -e "$LB$D Setting up Cursors...$LB$END"
######################################################################################

xfconf-query -c xsettings -p /Gtk/CursorThemeName -s $CURSOR

######################################################################################
# Set the Default Font
######################################################################################
echo -e "$LB$D Setting up Default Font...$LB$END"
######################################################################################

xfconf-query -c xsettings -p /Gtk/FontName -s $FONT

######################################################################################
# Set the Default Monospace Font
######################################################################################
echo -e "$LB$D Setting up Monospace Font...$LB$END"
######################################################################################

xfconf-query -c xsettings -p /Gtk/MonospaceFontName -s $FONT_MONO

######################################################################################
# Set the Terminal Configuration..
######################################################################################
echo -e "$LB$D Setting up Terminal Configurations...$LB$END"
######################################################################################

sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/xfce4-terminal 1000
sudo update-alternatives --set x-terminal-emulator /usr/bin/xfce4-terminal

# sudo update-alternatives --config x-terminal-emulator # to do it manually if the above commands doesn't work

xfconf-query -c xfce4-terminal -p /misc/cursor-shape -s "underline"
xfconf-query -c xfce4-terminal -p /misc/cursor-blink-mode -s "on"
xfconf-query -c xfce4-terminal -p /misc/copy-on-select -s true
xfconf-query -c xfce4-terminal -p /misc/scrollback-lines -s -1
xfconf-query -c xfce4-terminal -p /misc/dynamic-title -s false
xfconf-query -c xfce4-terminal -p /misc/show-menubar -s false
xfconf-query -c xfce4-terminal -p /misc/show-toolbar -s false
xfconf-query -c xfce4-terminal -p /misc/borderless -s false
xfconf-query -c xfce4-terminal -p /misc/show-scrollbar -s false
xfconf-query -c xfce4-terminal -p /misc/paste-notification -s false

######################################################################################
## Set up Picom
######################################################################################
echo -e "$LB$D Setting up Picom...$LB$END"
######################################################################################

cd $DIR_BASE
#cd ~/Downloads
#git clone https://github.com/yshui/picom
#cd picom
cd $CONFIG/picom
git submodule update --init --recursive
meson setup --buildtype=release . build
sudo ninja -C build
sudo ninja -C build install
picom --config ~/.config/picom/picom.conf
xfconf-query -c xfwm4 -p /general/use_compositing -s false

echo -e "[Desktop Entry]\nType=Application\nName=Picom Startup\nComment=Picom Compositor\nExec=picom --config ~/.config/picom/picom.conf\nX-GNOME-Autostart-enabled=true" > $DIR_AUTOSTART/picom.desktop

######################################################################################
## Set the lockscreen display manager (LightDM)
######################################################################################
echo -e "$LB$D Setting up the LightDM Lockscreen Display Manager...$LB$END"
######################################################################################

# Path to the LightDM GTK+ Greeter configuration file
CONFIG_FILE="/etc/lightdm/lightdm-gtk-greeter.conf"

# Create a backup of the original configuration file
cp -e "$CONFIG_FILE" "${CONFIG_FILE}.bak"

# Set the preferences
bash lightdm/update-greeter.sh 

#sudo service lightdm restart

######################################################################################
#  Configure XFCE4 Panel
######################################################################################
echo -e "$LB$D Setting up XFCE Panel...$LB$END"
######################################################################################

xfce4-panel --quit
pkill xfconf
xfce4-panel &

######################################################################################
#  Configure Dock-like plugin
######################################################################################
echo -e "$LB$D Setting up Dock...$LB$END"
######################################################################################

cd $DIR_BASE
#git clone https://gitlab.xfce.org/panel-plugins/xfce4-docklike-plugin
#cd xfce4-docklike-plugin
cd $CONFIG/docklike
bash ./autogen.sh --prefix=/usr/local
make
sudo make install
sudo cp src/docklike.desktop /usr/share/xfce4/panel/plugins
sudo cp src/.libs/libdocklike.so /usr/lib/x86_64-linux-gnu/xfce4/panel/plugins/
sudo cp src/libdocklike.la /usr/lib/x84_64-linux-gnu/xfce4/panel/plugins/

# Add Docklike-taskbar
# Force icons size 24
# Archive indicator style none
# Inactive indicator style none
# Show previrew thumbnails for open windows
# Show the number of open windows if more than 2

######################################################################################
#  Configure Eww Widget
######################################################################################
echo -e "$LB$D Setting up the EWW Widget...$LB$END"
######################################################################################

RUSTUP='export RUSTUP_HOME="$HOME/.local/share/rustup"'
CARGO='export CARGO_HOME="$HOME/.local/share/cargo"'
SHELL=~/.zshrc

if ! grep -qF "$RUSTUP" "$SHELL"; then
    echo >> "$SHELL"
    echo "$RUSTUP" >> "$SHELL"
    echo "$CARGO" >> "$SHELL"
fi

curl --proto '=https' --tlsv1.2  -sSf https://sh.rustup.rs | sh
source $CARGO/env
#git clone https://github.com/elkowar/eww
#cd eww
cd $CONFIG/eww
cargo build --release
sudo cp target/release/eww /usr/bin
eww open --togle sidebar

######################################################################################
#  Configure Findex Search Launcher
######################################################################################
echo -e "$LB$D Setting up Findex Search Launcher...$LB$END"
######################################################################################

cd $CONFIG/findex | bash installer.sh -y

echo -e "[Desktop Entry]\nType=Application\nName=Findex Search Launcher\nComment=Findex Search Launcher\nExec=findex\nX-GNOME-Autostart-enabled=true\nX-XFCE-Autostart-enabled=true\nX-XFCE-Autostart-Delay=0" > ~/.config/autostart/<program-name>.desktop

######################################################################################
#  Configure I3LOCK
######################################################################################
echo -e "$LB$D Setting up I3LOCK...$LB$END"
######################################################################################

sudo cp $CONFIG/i3-locker/i3-locker-everblush /usr/bin

xfconf-query --create -c xfce4-session -p /general/LockCommand -t string -s "i3-lock-everblush"

# Disable light-locker screen from startup
sudo rm -rf /etc/xdg/autostart/light-locker.desktop
