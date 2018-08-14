# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export TERM="xterm-256color"

#set vim keybindings (seems to break when used with oh-my-zsh)
#bindkey -v

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel9k/powerlevel9k"

# https://github.com/zsh-users/zsh-autosuggestions.git
plugins=(
  git python zsh-autosuggestions 
  zsh-syntax-highlighting)

# source the plugins
source $ZSH/oh-my-zsh.sh 
# brew install zsh-syntax-highlighting
source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# brew install zsh-autosuggestions
source ~/.oh-my-zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


case `uname` in
  Darwin)
    # commands for OS X go here
    # setup alias for MacVim
    alias vim='/usr/local/Cellar/macvim/8.0-146_1/MacVim.app/Contents/MacOS/Vim'
    # setup "Z" on MACOS
    # brew install z
    . `brew --prefix`/etc/profile.d/z.sh
    # simplenote date alias on osX
    local LASTWEEK=$(date -j -v-1w +"%Y-%m-%d")
  ;;
  Linux)
    # commands for Linux go here
   alias copy='xclip -sel clip'
    # allow access to Vagrant from WSL
    export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
    #setup the z plugin on WSL
    . ~/z.sh
    unsetopt BG_NICE # fixes "zsh: nice(5) failed: operation not permitted" issue when running z on WSL
  ;;
  FreeBSD)
    # commands for FreeBSD go here
  ;;
esac

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# taken from https://stackoverflow.com/questions/3964068/zsh-automatically-run-ls-after-every-cd
function chpwd() 
{
    emulate -L zsh
    ls -a
}

#change format for time
HISTTIMEFORMAT="%F %R%z "

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
