#!/bin/bash
# Install Text Editor -> 1. atom      2. Sublime      3. VScode


function install_atom() {
    # Install atom
    versions=('atom' 'atom-beta' 'Quit')
    wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add
    sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
    sudo apt-get update
    PS3=$(echo_prompt '\nChoose The Atom Version You Want To Install: ')
    select VERSION in "${versions[@]}"; do
        case "${VERSION}" in
            'atom')
                sudo apt-get install atom -y
                break;;
            'atom-beta')
                sudo apt-get install atom-beta -y
                break;;
            'Quit')
                echo_info 'Quiting...'
                exit 0;;
            *) echo_warning "Invalid Option \"${REPLY}\"";;
        esac
    done
}


function install_sublime() {
    # Install sublime stable
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add
    sudo apt-get install apt-transport-https -y
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt-get update
    sudo apt-get install sublime text -y
}


function install_vscode() {
    # Install VSCode
    PS3=$(echo_prompt '\nChoose Whether To Install VSCode: ')
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    sudo apt install apt-transport-https -y
    sudo apt update
    sudo apt install code -y
}


function install_text_editor() {
    # Install required test editor
    text_editors=('atom' 'sublime' 'vscode' 'No Editor' 'Quit')
    PS3=$(echo_prompt '\nChoose The Text Editor You Want To Install: ')
    select EDITOR in "${text_editors[@]}"; do
        case "${EDITOR}" in
            'atom')
                install_atom
                break;;
            'sublime')
                install_sublime
                break;;
            'vscode')
                install_vscode
                break;;
            'No Editor')
                break;;
            'Quit')
                echo_info 'Quiting...'
                exit 0;;
            *) echo_warning "Invalid Option \"${REPLY}\"";;
        esac
    done
}
