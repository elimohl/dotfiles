# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' expand suffix
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+r:|[ ]=* r:|=*'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' original false
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-compctl true
zstyle :compinstall filename '/home/elsie/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
bindkey -v
# End of lines configured by zsh-newuser-install

# Reverse search
bindkey '^R' history-incremental-search-backward

# Edit in vim
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Prompt
autoload -Uz promptinit
promptinit
prompt walters

# Aliases
alias python=python3
alias pip=pip3
alias ipython=ipython3
alias wttr="curl http://wttr.in/Москва"
alias upgrade="sudo apt-get update && sudo apt-get upgrade && sudo apt-get autoremove && sudo apt-get clean"
alias dist-upgrade="sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoremove && sudo apt-get clean"
alias noise="play -n synth brownnoise synth pinknoise mix synth sine amod 0.3 10"
alias ls='ls --color=auto'
alias icat="kitty +kitten icat"

# Paths
export PATH="$HOME/.local/bin:/usr/sbin:/sbin:$PATH"

TERM=xterm-256color
