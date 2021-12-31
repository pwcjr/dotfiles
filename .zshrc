# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000000
SAVEHIST=10000000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
source ~/.powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zsh match upper case when using lower case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# zsh highlight selected autocomplete option
zstyle ':completion:*' menu select

# allow backspace delete in vi-mode after switching to input mode from normal mode
bindkey "^?" backward-delete-char

#------------------------------------------------------------------------------
# aliases
#------------------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
# dotfiles goodness
alias dotfiles='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
# nicer LS
LS=exa
alias lsl="$LS -lFgH --color=auto --time-style=long-iso --group-directories-first"
# color grep matches
alias grep='grep --color'
# reload config
alias zr='source ~/.zshrc'
# fetch Arch Linux mirror updates
alias update-mirrors="curl 'https://archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4&use_mirror_status=on' | sed 's/#Server/Server/' | rankmirrors -vn 10 - | tee mirrorlist.ranked"

setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY_TIME

# zsh extensions from Arch repos
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# added by Anaconda3 2021.05 installer
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

source "$HOME/.cargo/env"
