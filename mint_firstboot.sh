#!/bin/bash
# Make sure that this file is executable

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
    sudo apt update
    sudo apt upgrade -y
    sudo apt install git -y
}

function install_google_chrome() {
    # Install google chrome
    sudo apt update
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt install ./google-chrome-stable_current_amd64.deb -y
	rm google-chrome-stable_current_amd64.deb
}


function install_brave() {
    # Install brave
    sudo apt install apt-transport-https curl
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


function set_dual_boot_timezone() {
    # Linux and windows dual time issue occurs because linux assues UTC time for hardware clock and syncs software clock accordingly and windows thinks that the hardware clock is as set as per local time and uses that to display software time
    # While issue can be fixed in both linux and windows, I fix it in linux as I prefer it.
    echo "Current time info"
    timedatectl
    timedatectl set-local-rtc 1 
    echo "Changed time info"
    timedatectl
    echo "Restart into Windows and check the time"
}


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
                sudo apt-get install atom
                break;;
            'atom-beta')
                sudo pat-get install atom-beta
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
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    sudo apt-get install apt-transport-https
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt-get update
    sudo apt-get install sublime text
}


function install_text_editor() {
    # Install required test editor
    text_editors=('atom' 'sublime' 'No Editor' 'Quit')
    PS3=$(echo_prompt '\nChoose The Text Editor You Want To Install: ')
    select EDITOR in "${text_editors[@]}"; do
        case "${EDITOR}" in
            'atom')
                install_atom
                break;;
            'sublime')
                install_sublime
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


function install_vscode() {
    # Install VSCode
    install_vscode=('yes' 'no')
    PS3=$(echo_prompt '\nChoose Whether To Install VSCode: ')
    select INSTALL in "${install_code[@]}"; do
        case "${INSTALL}" in
            'yes')
                wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
                sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
                sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
                rm -f packages.microsoft.gpg
                sudo apt install apt-transport-https
                sudo apt update
                sudo apt install code
                break;;
            'no')
                break;;
            *) echo_warning "Invalid Option \"${REPLY}\"";;
        esac
    done
}


function install_sleek_bootloader() {
    # Install sleek bootloader
    git clone https://github.com/sandesh236/sleek--themes.git
    sleek_themes=('Dark' 'Light' 'Orange' 'Bigsur' 'Quit')
    PS3=$(echo_prompt '\nChoose The Sleek Theme You Want To Install: ')
    select THEME in "${sleek_themes[@]}"; do
        case "${THEME}" in
            'Dark')
                cd Sleek\ theme-dark
                sudo ./install.sh
                break;;
            'Light')
                cd Sleek\ theme-white
                sudo ./install.sh
                break;;
            'Orange')
                cd Sleektheme-orange
                sudo ./install.sh
                break;;
            'Bigsur')
                cd Sleek\ theme-bigSur
                sudo ./install.sh
                break;;
            'Quit')
                echo_info 'Quiting...'
                exit 0;;
            *) echo_warning "Invalid Option \"${REPLY}\"";;
        esac
    done
    rm -rf sleek--themes
}


function install_dark_matter_theme() {
    # Install dark matter theme
    git clone --depth 1 https://github.com/vandalsoul/darkmatter-grub2-theme.git
    cd darkmatter-grub2-theme
    sudo python3 install.py
}


function install_grub() {
    # Install required grubbootloader
    grub_themes=('Sleek GrubBootLoader' 'Dark Matter Grub Theme' 'No Theme' 'Quit')
    PS3=$(echo_prompt '\nChoose The Browser/Browsers You Want To Install: ')
    select BOOTLOADER in "${grub_themes[@]}"; do
        case "${BOOTLOADER}" in
            'Sleek GrubBootLoader')
                install_sleek_bootloader
                break;;
            'Dark Matter Grub Theme')
                install_dark_matter
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


function install_icon_theme_papirus() {
    # Install Papirus
    sudo sh -c "echo 'deb http://ppa.launchpad.net/papirus/papirus/ubuntu focal main' > /etc/apt/sources.list.d/papirus-ppa.list"
    sudo apt-get install dirmngr
    sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com E58A9D36647CAE7F
    sudo apt-get update
    sudo apt-get install papirus-icon-theme
    gsettings set org.cinnamon.desktop.interface icon-theme "papirus"
}


function install_icon_theme_la_capitaine() {
    # Install la capitaine
    git clone https://github.com/keeferrourke/la-capitaine-icon-theme.git la-capitaine
    cd la-capitaine
    ./configure
    cd ..
    rm -rf la-capitaine
    gsettings set org.cinnamon.desktop.interface icon-theme "la-capitaine"
}


function install_icon_theme_popos() {
    # Install popos
    git clone https://github.com/pop-os/icon-theme pop-icon-theme
    cd pop-icon-theme
    sudo install meson
    meson build
    sudo ninja -C "build" install
    sudo apt autoremove meson
    cd ..
    rm -rf pop-icon-theme
    gsettings set org.cinnamon.desktop.interface icon-theme "Pop"
}


function install_icon_theme_paper() {
    # Install paper
    sudo dpkg -i paper*.deb
    sudo apt install -f
    gsettings set org.cinnamon.desktop.interface icon-theme "Paper"
}


function install_icon_theme() {
    # Install icon theme
    icon_themes=('Paper' 'Pop-os' 'la-capitaine' 'Papirus' 'No Theme' 'Quit')
    PS3=$(echo_prompt '\nChoose The Icon Theme You Want To Install: ')
    select THEME in "${icon_themes[@]}"; do
        case "${THEME}" in
            'Paper')
                install_icon_theme_paper
                break;;
            'Pop-os')
                install_icon_theme_popos
                break;;
            'la-capitaine')
                install_icon_theme_la_capitaine
                break;;
            'Papirus')
                install_icon_theme_papirus
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


function enable_numlock_on_bootup() {
    sudo apt-get install numlockx
    echo -e "if [ -x /usr/bin/numlockx ]; then\n\t/usr/bin/numlockx on\nfi" >> /etc/mdm/Init/Default
}


function main() {
    install_git
    install_browser
    install_grub
    install_text_editor
    install_vscode
    install_icon_theme
    enable_numlock_on_bootup

    set_dual_boot_timezone
}

main
