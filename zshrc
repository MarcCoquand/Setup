# Created by newuser for 5.0.5
autoload -U promptinit && promptinit
#promptinit
autoload -U colors && colors
bindkey -v

source $HOME/.aliases
setopt prompt_subst

export PATH=/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin:/usr/local/bin:$PATH
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

# Reset mode-marker and prompt whenever the keymap changes
function zle-line-init zle-keymap-select {
  vi_mode="$(vi_mode_indicator)"
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

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
    echo '»' 
  else 
    echo '›' 
  fi
}


PROMPT=' %{$fg[green]%}$(prompt_git)%{$reset_color%}%}  %{$fg[blue]%}%~%{$reset_color%} '

case $TERM in
    (*xterm* | rxvt)
  function precmd {
    print -Pn "\e]0;zsh%L %(1j,%j job%(2j|s|); ,)%~\a"
  }
  function preexec {
    printf "\033]0;%s\a" "$1"
  }
  ;;
esac
BASE16_SCHEME="default"
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL  ]] && source $BASE16_SHELL

alias sshumu="ssh id14mcd@itchy.cs.umu.se"
scpumu () {scp $1 id14mcd@itchy.cs.umu.se:$2}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export KEYTIMEOUT=1

export PATH=$PATH:/Users/marccoquand/Library/Android/sdk/platform-tools
