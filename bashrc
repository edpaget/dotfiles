# Exit if not running interactively
[ -z "$PS1" ] && return

if [ -e "$HOME/.bash/env" ] ; then
  source "$HOME/.bash/env"
fi

if [ -e "$HOME/.bash/config" ] ; then
  source "$HOME/.bash/config"
fi

if [ -e "$HOME/.bash/prompt" ] ; then
  source "$HOME/.bash/prompt"
fi

if [ -e "$HOME/.bash/aliases" ] ; then
  source "$HOME/.bash/aliases"
fi

## Activate RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# added by travis gem
[ -f /home/edward/.travis/travis.sh ] && source /home/edward/.travis/travis.sh

export NVM_DIR="/home/edward/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
