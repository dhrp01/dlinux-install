#!/bin/bash
# Install icon packs -> 1. Papirus      2. LaCapitaine      3. PopOs        4. Paper

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


function install_icon_theme_papirus() {
    # Install Papirus Icons
    sudo sh -c "echo 'deb http://ppa.launchpad.net/papirus/papirus/ubuntu focal main' > /etc/apt/sources.list.d/papirus-ppa.list"
    sudo apt-get install dirmngr -y
    sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com E58A9D36647CAE7F
    sudo apt-get update
    sudo apt-get install papirus-icon-theme -y
}


function install_icon_theme_la_capitaine() {
    # Install La Capitaine
    git clone https://github.com/keeferrourke/la-capitaine-icon-theme.git ~/.icons/la-capitaine
    cd ~/.icons/la-capitaine/
    chmod +x configure
    ./configure
    cd -
}


function install_icon_theme_popos() {
    # Install PopOs Icons
    git clone https://github.com/pop-os/icon-theme pop-icon-theme
    cd pop-icon-theme
    sudo apt install meson -y
    meson build
    sudo ninja -C "build" install
    cd ..
}


function install_icon_theme_paper() {
    # Install Paper Icons
    sudo add-apt-repository ppa:snwh/ppa
    sudo apt update
    sudo apt-get install paper-icon-theme
}


function install_icon_theme() {
    # Install icon theme
    install_icon_theme_paper
    install_icon_theme_popos
    install_icon_theme_la_capitaine
    install_icon_theme_papirus
    icon_themes=('Paper' 'Pop-os' 'la-capitaine' 'Papirus' 'No Theme' 'Quit')
    PS3=$(echo_prompt '\nChoose The Icon Theme You Want To Set: ')
    select THEME in "${icon_themes[@]}"; do
        case "${THEME}" in
            'Paper')
                gsettings set org.cinnamon.desktop.interface icon-theme "Paper"
                break;;
            'Pop-os')
                gsettings set org.cinnamon.desktop.interface icon-theme "Pop"
                break;;
            'la-capitaine')
                gsettings set org.cinnamon.desktop.interface icon-theme "la-capitaine"
                break;;
            'Papirus')
                gsettings set org.cinnamon.desktop.interface icon-theme "Papirus"
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
