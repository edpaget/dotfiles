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
