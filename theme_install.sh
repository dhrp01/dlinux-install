#!/bin/bash
# Install themes -> 1. Nordic       2. Mc-Os        3. Paper        4. PopOs        5. Ant

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


function install_nordic_theme() {
  # Install Nordic theme
  # https://github.com/EliverLara/Nordic
  git clone https://github.com/EliverLara/Nordic
  mv Nordic ~/.themes
}


function install_mc_os_theme() {
  # Install mc os theme
  # https://github.com/paullinuxthemer/Mc-Os-themes
  # https://github.com/paullinuxthemer/McOs-Mint-Cinnamon-Edition
  git clone https://github.com/paullinuxthemer/Mc-OS-themes McOs
  git clone https://github.com/paullinuxthemer/McOs-Mint-Cinnamon-Edition McOsCinnamon
  mv McOs/* ~/.themes/
  mv McOsCinnamon/* ~/.themes/
}

function install_paper_theme() {
  # Install paper theme
  # https:/snwh.org/paper
  git clone https://github.com/snwh/paper-gtk-theme PaperTheme
  cd PaperTheme && ./install-gtk-theme.sh && cd ..
}

function install_pop_os_theme() {
  # Install PopOs theme
  sudo apt install sassc meson libglib2.0-dev -y
  sudo apt install inkscape optipng -y
  # Clean up if Pop Theme already present
  sudo apt remove pop-gtk-theme -y
  sudo rm -rf /usr/share/themes/Pop*
  rm -rf ~/.local/share/themes/Pop*
  rm -rf ~/.themes/Pop*
  git clone https://github.com/pop-os/gtk-theme.git
  cd gtk-theme
  meson build && cd build
  sudo ninja && sudo ninja install
  cd ../..
}

function install_ant_theme() {
  # Install ant theme
  # https://github.com/EliverLara/Ant
  git clone https://github.com/EliverLara/Ant
  mv Ant ~/.themes/
}

function install_theme() {
    # Install Theme
    install_paper_theme
    install_pop_os_theme
    install_mc_os_theme
    install_nordic_theme
    install_ant_theme
    icon_themes=('Paper' 'PopOs' 'Mc-Os' 'Nordic' 'Ant' 'No Theme' 'Quit')
    PS3=$(echo_prompt '\nChoose The Theme You Want To Set: ')
    select THEME in "${icon_themes[@]}"; do
        case "${THEME}" in
            'Paper')
                gsettings set org.cinnamon.desktop.interface gtk-theme "Paper"
                break;;
            'PopOs')
                gsettings set org.cinnamon.desktop.interface gtk-theme 'Pop'
                break;;
            'Mc-Os')
                gsettings set org.cinnamon.desktop.interface gtk-theme 'McOS-CTLina-Mint-Dark'
                break;;
            'Nordic')
                gsettings set org.cinnamon.desktop.interface gtk-theme 'Nordic'
                break;;
            'Ant')
                gsettings set org.cinnamon.desktop.interface gtk-theme 'Ant'
                break;;
            'No Theme')
                break;;
            'Quit')
                echo_info 'Quiting...'
                exit 0;;
            *) echo_warning "Invalid Option \"${REPLY}\"";;
        esac
    done
}

install_theme
