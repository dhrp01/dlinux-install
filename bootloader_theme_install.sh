#!/bin/bash
# Install Grub bootloader themes -> 1. Sleek Bootloader   a. Dark   b. Light   c. Orange   d. Bigsur        2. Dark Matter

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


function install_sleek_bootloader() {
    # Install sleek bootloader
    git clone https://github.com/sandesh236/sleek--themes.git
    cd sleek--themes
    if [ $1=='Dark' ];
    then
        sudo ./Sleek\ theme-dark/install.sh
    elif [ $1=='Light' ];
    then
        sudo ./Sleek\ theme-white/install.sh
    elif [ $1=='Orange' ];
    then
        sudo ./Sleek\ theme-orange/install.sh
    elif [ $1=='Bigsur' ];
    then
        sudo ./Sleek\ theme-bigSur/install.sh
    else
        sudo ./Sleek\ theme-dark/install.sh
    fi
    cd ..
}


function install_darkmatter_bootloader() {
    # Install dark matter theme
    git clone --depth 1 https://github.com/vandalsoul/darkmatter-grub2-theme.git
    cd darkmatter-grub2-theme
    sudo python3 install.py
    cd ..
}


function install_grub() {
    # Install required grubbootloader
    grub_themes=('Sleek GrubBootLoader Dark' 'Sleek GrubBootLoader Light' 'Sleek GrubBootLoader Orange' 'Sleek GrubBootLoader Bigsur' 'Dark Matter Grub Theme' 'No Theme' 'Quit')
    PS3=$(echo_prompt '\nChoose The Browser/Browsers You Want To Install: ')
    select BOOTLOADER in "${grub_themes[@]}"; do
        case "${BOOTLOADER}" in
            'Sleek GrubBootLoader Dark')
                install_sleek_bootloader dark
                break;;
            'Sleek GrubBootLoader Light')
                install_sleek_bootloader light
                break;;
            'Sleek GrubBootLoader Orange')
                install_sleek_bootloader orange
                break;;
            'Sleek GrubBootLoader Bigsur')
                install_sleek_bootloader bigsur
                break;;
            'Dark Matter Grub Theme')
                install_darkmatter_bootloader
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
