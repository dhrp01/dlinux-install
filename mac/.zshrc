
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
PATH=/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/code.system/bosotstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Users/dhrumeen/.cargo/bin:/Applications/kitty.app/Contents/MacOS:~/.local/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Ctrl+R -> Search history
# Ctrl+T -> Search directory/files
# Github link for git ingnore: fzf
# Github link for autocomplete
# Can add to nvim/vim/lvim

alias ls='eza --icons --colour always'
alias cat='bat'

# Variables

# server cmd
alias server='ssh dhrumeen@10.0.0.240'

# starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# fzf
source <(fzf --zsh)
