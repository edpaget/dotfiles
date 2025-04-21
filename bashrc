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

if [ -e "$HOME/.bash/env" ] ; then
   source "$HOME/.cargo/env"
fi

_bb_tasks() {
    COMPREPLY=( $(compgen -W "$(bb tasks |tail -n +3 |cut -f1 -d ' ')" -- ${COMP_WORDS[COMP_CWORD]}) );
}
# autocomplete filenames as well
complete -f -F _bb_tasks mage
