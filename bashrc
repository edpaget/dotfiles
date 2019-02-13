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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
