if [ -e "$HOME/.bashrc" ] ; then
  source "$HOME/.bashrc"
fi

export BASH_SILENCE_DEPRECATION_WARNING=1

export PATH="$HOME/.cargo/bin:$PATH"
