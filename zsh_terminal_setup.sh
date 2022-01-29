#!/bin/bash
# Install zsh terminal and customize terminal
 
function terminal_setup_zsh() {
  # Install zsh and setup
  # Get UUID of all the profiles
  # gsettings get org.gnome.Terminal.ProfilesList list
  # Get default profile UUID
  default_profile_uid=$(gsettings get org.gnome.Terminal.ProfilesList default)
  # Remove quote ("'") from UUID
  default_profile_uid=$(echo default_profile_uid | sed s/"'"//g)
  # Disable system theme and change background colour to black and foreground to green (Green on black scheme)
  gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${default_profile_uid}/ use-theme-colors false
  gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${default_profile_uid}/ background-color 'rgb(0,0,0)'
  gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${default_profile_uid}/ foreground-color 'rgb(0,255,0)'
  # Setup transparency for terminal
  gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${default_profile_uid}/ use-theme-transparency false
  gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${default_profile_uid}/ use-transparent-background true
  gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${default_profile_uid}/ background-transparency-percent 10
  # Download and setup fonts needed for power10k
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
  mv MesloLGS* ~/.local/share/fonts/
  # Install zsh dependency and power10k
  sudo apt install zsh zsh-syntax-highlighting autojump zsh-autosuggestions -y
  touch "$HOME/.cache/zshhistory"
  # Power10k: https://github.com/romkatv/powerlevel10k
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
  echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
  # Uncomment to install ohmyzsh
  # sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  # git clone https://github.com/ChrisTitusTech/zsh
  git clone https://github.com/ChrisTitusTech/zsh
  #/bin/bash | chsh $USER
}
