## BEGIN ZSH CONFIGURATION ##

# Detect OS
OS=`uname`
IS_MAC=false
if [[ "$OS" == "Darwin" ]]; then
    IS_MAC=true
fi

# Path to your oh-my-zsh installation.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="philips"

# Command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    # git
    # gitfast
    # git-extras
    # command-not-found
    # npm
    # node
    #zsh-256color
    colored-man-pages
    docker
    docker-compose
    # extract
    #vi-mode
)

export LANG=en_US.UTF-8
export EDITOR='nvim'

# Set history size for reverse search
HISTSIZE=50000 # session history size
SAVEHIST=10000 # saved history

# Start oh-my-zsh
source $ZSH/oh-my-zsh.sh

## END ZSH CONFIGURATION ##


## BEGIN CUSTOM CONFIGURATION ##

# Preferred temp directory
export TEMP=~/.tmp/
if [ ! -d ~/.tmp ]; then
    mkdir ~/.tmp
fi

# Vim temp directories
mkdir -p ~/.tmp/.vim/.undo
mkdir -p ~/.tmp/.vim/.backup

# Zaw style configuration
zstyle ':filter-select:highlight' matched fg=green
zstyle ':filter-select' max-lines -1
zstyle ':filter-select' case-insensitive yes # enable case-insensitive
zstyle ':filter-select' extended-search yes # see below
zstyle ':filter-select' hist-find-no-dups yes # ignore duplicates in history source

# Alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Custom functions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# Automatically 'ls -F' after every CD
[ -z "$PS1" ] && return
function cd {
    builtin cd "$@" && ls -F
}

env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && source "$env" >| /dev/null }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    source "$env" >| /dev/null }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [[ -z $SSH_AUTH_SOCK ]] || [[ $agent_run_state = 2 ]]; then
    agent_start
    ssh-add
elif [[ -n $SSH_AUTH_SOCK ]] && [[ $agent_run_state = 1 ]]; then
    ssh-add
fi

unset env

GPG_TTY=$(tty)
export GPG_TTY

export PATH=/home/brandon/.local/bin:$PATH

# Fix "Directory writable to others, no sticky bit" background colors
export LS_COLORS="${LS_COLORS}:ow=32;40"

## END CUSTOM CONFIGURATION

export COLIMA_VM="default"
export COLIMA_VM_SOCKET="${HOME}/.colima/${COLIMA_VM}/docker.sock"
export DOCKER_HOST="unix://${COLIMA_VM_SOCKET}"


## BEGIN PATH MODIFICATION
export PATH=/opt/local/bin:$PATH

export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
