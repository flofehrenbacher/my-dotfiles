# If not running interactively, don't do anything

[ -z "$PS1" ] && return

# Resolve DOTFILES_DIR
if [ -d "/projects/settings/.dotfiles" ]; then
  DOTFILES_DIR="/projects/settings/.dotfiles"
else
  echo "Unable to find dotfiles, exiting."
  return
fi

# Source the dotfiles (order matters)
for DOTFILE in "$DOTFILES_DIR"/system/.{env,functions,alias,zshinit}; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
done


# specific dotfiles (order hopefully doesn't matter)
if [ -d "$DOTFILES_DIR"/specific ]; then
  for SPECIFIC_DOTFILE in "$DOTFILES_DIR"/specific/.*.specific; do
    [ -f "$SPECIFIC_DOTFILE" ] && . "$SPECIFIC_DOTFILE"
  done
fi

# z command
. ~/projects/help-tools/z/z.sh

# rbenv init for ruby
eval "$(rbenv init -)"

# Export
export DOTFILES_DIR
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/Library/Python/3.7/bin:$PATH
export PATH=$HOME/terraform:$PATH
export CHEAT_CONFIG_PATH="/projects/settings/.dotfiles/cheat/conf.yml"

ssh-add -K $HOME/.ssh/id_rsa > /dev/null
[ -f "/Users/fehrenbachf/.ghcup/env" ] && source "/Users/fehrenbachf/.ghcup/env" # ghcup-env
