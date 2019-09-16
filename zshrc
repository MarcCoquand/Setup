autoload -U promptinit && promptinit
#promptinit
autoload -U colors && colors
bindkey -v

setopt prompt_subst

# Set the colors to your liking
local vi_normal_marker="%{$fg[green]%}%BN%b%{$reset_color%}"
local vi_insert_marker="%{$fg[red]%}%BI%b%{$reset_color%}"
local vi_unknown_marker="%{$fg[red]%}%BU%b%{$reset_color%}"
local vi_mode="$vi_insert_marker"
vi_mode_indicator () {
  case ${KEYMAP} in
    (vicmd)      echo $vi_normal_marker ;;
    (main|viins) echo $vi_insert_marker ;;
    (*)          echo $vi_unknown_marker ;;
  esac
}
export PATH=/home/marccoquand/.dotnet/tools:$PATH

export NNN_TMPFILE="/tmp/nnn"

n()
{
        nnn "$@"

        if [ -f $NNN_TMPFILE ]; then
                . $NNN_TMPFILE
                rm $NNN_TMPFILE
        fi
}
# Reset mode-marker and prompt whenever the keymap changes
# function zle-line-init zle-keymap-select {
  # vi_mode="$(vi_mode_indicator)"
  # zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select

zle-keymap-select () {
if [ $KEYMAP = vicmd ]; then
    printf "\033[2 q"
else
    printf "\033[6 q"
fi
}
zle -N zle-keymap-select
zle-line-init () {
zle -K viins
printf "\033[6 q"
}
zle -N zle-line-init
bindkey -v

# Multiline-prompts don't quite work with reset-prompt; we work around this by
# printing the first line(s) via a precmd which is executed before the prompt
# is printed.  The following can be integrated into PROMPT for single-line
# prompts.
#

function prompt_branch {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'  && echo ':'
  fi
}

function prompt_git {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    echo '∙ ' 
  else 
    echo '' 
  fi
}

alias open='xdg-open'
alias vim='nvim'
function gc() {
    git add .
    if [ "$1" != "" ]
    then
        git commit -m "$1"
    else
        git commit -m update 
    fi
}
function gp() {
    git push origin $1
}


PROMPT='[%{$fg_bold[white]%}$(prompt_git)%{$reset_color%}%{$fg[blue]%}%~%{$reset_color%}] '

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/marccoquand/.sdkman"
[[ -s "/home/marccoquand/.sdkman/bin/sdkman-init.sh" ]] && source "/home/marccoquand/.sdkman/bin/sdkman-init.sh"

# opam configuration
test -r /home/marccoquand/.opam/opam-init/init.zsh && . /home/marccoquand/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
