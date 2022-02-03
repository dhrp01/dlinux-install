#!/bin/bash
# Make sure that this file is executable

source ./zsh_terminal_setup.sh
source ./text_editor_install.sh
source ./browser_install.sh
source ./bootloader_theme_install.sh
source ./icon_pack_install.sh
source ./theme_install.sh

function echo_title() {     echo -ne "\033[1;44;37m${*}\033[0m\n"; }
function echo_caption() {   echo -ne "\033[0;1;44m${*}\033[0m\n"; }
function echo_bold() {      echo -ne "\033[0;1;34m${*}\033[0m\n"; }
function echo_danger() {    echo -ne "\033[0;31m${*}\033[0m\n"; }
function echo_success() {   echo -ne "\033[0;32m${*}\033[0m\n"; }
function echo_warning() {   echo -ne "\033[0;33m${*}\033[0m\n"; }
function echo_secondary() { echo -ne "\033[0;34m${*}\033[0m\n"; }
function echo_info() {      echo -ne "\033[0;35m${*}\033[0m\n"; }
function echo_primary() {   echo -ne "\033[0;36m${*}\033[0m\n"; }
function echo_error() {     echo -ne "\033[0;1;31merror:\033[0;31m\t${*}\033[0m\n"; }
function echo_label() {     echo -ne "\033[0;1;32m${*}:\033[0m\t"; }
function echo_prompt() {    echo -ne "\033[0;36m${*}\033[0m "; }


function install_git() {
    # Install git
    # Funny thing if your cloning you should already have this :xD, but in case it is on some kind of removable drive and also it will update the system before starting
    sudo apt update
    sudo apt upgrade -y
    sudo apt install git -y
}


function set_dual_boot_timezone() {
    # Linux and windows dual time issue occurs because linux assues UTC time for hardware clock and syncs software clock accordingly and windows thinks that the hardware clock is set as per local time and uses that to display software time
    # While issue can be fixed in both linux and windows, I prefer fixing it in linux.
    echo_bold "Current time info"
    timedatectl
    timedatectl set-local-rtc 1
    echo_bold "Changed time info"
    timedatectl
    echo "Restart into Windows and check the time"
}


function enable_numlock_on_bootup() {
    # Enable NumLock on startup
    sudo apt-get install numlockx
    echo -e "if [ -x /usr/bin/numlockx ]; then\n\t/usr/bin/numlockx on\nfi" >> /etc/mdm/Init/Default
}


function buttons() {
  # Change the close,minimize,maximize button layout and pick the needed buttons theme
  gsettings set org.cinnamon.desktop.wm.preferences button-layout 'close,maximize,minimize:'
  gsettings set org.cinnamon.desktop.wm.preferences theme 'McOS-CTLina-Mint-Dark'
  gsettings set org.cinnamon.desktop.interface gtk-theme Paper
  gsettings set org.cinnamon.theme name 'Nordic'
  gsettings set org.cinnamon.desktop.interface cursor-theme 'Pop'
}


function alt_tab() {
  # Change alt_tab style
  gsettings set org.cinnamon alttab-switcher-style 'coverflow'
}


function show_all_windows() {
  # Show all Windows
  gsettings set org.cinnamon hotcorner-layout "['scale:true:0', 'scale:false:0', 'scale:false:0', 'desktop:false:0']"
}


function transparent_panels() {
  # Add transparent transparent panels
  git clone https://github.com/germanfr/cinnamon-transparent-panels.git
  cd cinnamon-transparent-panels
  ./utils.sh install
  gsettings set org.cinnamon enabled-extensions "['transparent-panels@germanfr']"
  sed -i 's/"value": "panel-.*/"value": "panel-semi-transparent"/g' ~/.cinnamon/configs/transparent-panels@germanfr/transparent-panels@germanfr.json
  sed -i -n -f transparent-panel.sed ~/.cinnamon/configs/transparent-panels@germanfr/transparent-panels@germanfr.json
  cd ..
}


function panel() {
  # move panel to the top
  gsettings set org.cinnamon panels-enabled "['1:0:top']"
  gsettings set org.cinnamon panels-autohide "['1:false']"
  gsettings set org.cinnamon panel-edit-mode true
  #gsettings set org.cinnamon enabled-applets "['panel1:right:0:systray@cinnamon.org:3', 'panel1:right:1:xapp-status@cinnamon.org:4', 'panel1:right:2:notifications@cinnamon.org:5', 'panel1:right:3:printers@cinnamon.org:6', 'panel1:right:4:removable-drives@cinnamon.org:7', 'panel1:right:5:keyboard@cinnamon.org:8', 'panel1:right:6:favorites@cinnamon.org:9', 'panel1:right:7:network@cinnamon.org:10', 'panel1:right:8:sound@cinnamon.org:11', 'panel1:right:9:power@cinnamon.org:12', 'panel1:right:10:calendar@cinnamon.org:13']"
  gsettings set org.cinnamon panel-edit-mode false
  install_cinnamenu
  install_weather
  gsettings set org.cinnamon enabled-applets "['panel1:right:4:systray@cinnamon.org:3', 'panel1:right:5:xapp-status@cinnamon.org:4', 'panel1:right:6:notifications@cinnamon.org:5', 'panel1:right:7:printers@cinnamon.org:6', 'panel1:right:8:removable-drives@cinnamon.org:7', 'panel1:right:9:keyboard@cinnamon.org:8', 'panel1:right:10:favorites@cinnamon.org:9', 'panel1:right:11:network@cinnamon.org:10', 'panel1:right:12:sound@cinnamon.org:11', 'panel1:right:13:power@cinnamon.org:12', 'panel1:right:14:calendar@cinnamon.org:13', 'panel1:left:0:Cinnamenu@json:14', 'panel1:right:3:weather@mockturtl:15', 'panel1:right:2:scale@cinnamon.org:16', 'panel1:right:1:expo@cinnamon.org:17', 'panel1:right:15:user@cinnamon.org:18']"
  sed -i -n -f transparent-panel.sed ~/.cinnamon/configs/Cinnamenu@json/*.json
  sed -i -n -f transparent-panel.sed /home/dhrumeen/.cinnamon/configs/calendar@cinnamon.org/13.json
}

function install_weather() {
  # Install weather
  wget https://cinnamon-spices.linuxmint.com/files/applets/weather@mockturtl.zip
  unzip weather@mockturtl.zip -d ~/.local/share/cinnamon/applets/
}

function install_cinnamenu() {
  # install Cinnamenu
  wget https://cinnamon-spices.linuxmint.com/files/applets/Cinnamenu@json.zip
  sudo apt-get install unzip -y
  unzip Cinnamenu@json.zip -d ~/.local/share/cinnamon/applets
}

function install_plank() {
  # Install plank
  sudo apt install plank -y
  echo -e "[Desktop Entry]\nType=Application\nExec=plank\nHidden=false\nNoDisplay=false\nX-GNOME-Autostart-enabled=true\nName=Plank" >> ~/.config/autostart/plank.desktop
  git clone https://github.com/Macintosh98/MacOS-Mojave-Plank-themes PlankMcTheme
  mkdir -p ~/.local/share/plank/themes
  sudo mv PlankMcTheme/themes/* ~/.local/share/plank/themes/
  gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ theme 'MacOS-BigSur-Light'
  gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ zoom-enabled true
  gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ zoom-percent 160
  gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ dock-items "['xed.dockitem', 'firefox.dockitem', 'org.gnome.Terminal.dockitem', 'trash.dockitem', 'desktop.dockitem']"
}

#function mc_os_setup() {
    # Something similar to Mc-Os can be done, will be adding it shortly.
    # Will probably create a separate bash script for this specific purpose
#}



#function login_screen() {
  # sudo apt install lightdm-gtk-greeter
  # Sort of pending in LinuxMint
#}

function main() {
    enable_numlock_on_bootup
    buttons
    alt_tab
    show_all_windows
    transparent_panels
    panel
    install_plank
    set_dual_boot_timezone
    reboot
}

main
