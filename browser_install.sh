#!/bin/bash
# Install the required browser -> 1. Google Chrome      2. Brave

function install_google_chrome() {
    # Install Google Chrome
    sudo apt update
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt install ./google-chrome-stable_current_amd64.deb -y
	rm google-chrome-stable_current_amd64.deb
}


function install_brave() {
    # Install Brave
    sudo apt install apt-transport-https curl -y
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser -y
}


function install_browser() {
    # Install browser of choice
    browsers=('Google Chrome' 'Brave' 'All' 'Quit')

    PS3=$(echo_prompt '\nChoose The Browser/Browsers You Want To Install: ')
    select BROWSER in "${browsers[@]}"; do
        case "${BROWSER}" in
            'Google Chrome')
                install_google_chrome
                break;;
            'Brave')
                install_brave
                break;;
            'All')
                install_google_chrome
                install_brave
                break;;
            'Quit')
                echo_info 'Quiting...'
                exit 0;;
            *) echo_warning "Invalid Option \"${REPLY}\"";;
        esac
    done
}

