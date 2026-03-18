#!/usr/bin/env bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTSIZE=10000                # Commands to keep in memory
HISTFILESIZE=20000            # Commands to keep in history file
HISTCONTROL=ignoreboth        # Ignore duplicates and commands starting with space
shopt -s histappend           # Append to history file, don't overwrite

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

shopt -s checkwinsize         # Update LINES and COLUMNS after each command
shopt -s globstar 2>/dev/null # Enable ** for recursive glob matching
shopt -s cdspell              # Autocorrect minor spelling errors in cd

# Function to get current git branch
git_branch() {
    local branch=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
    if [ -n "$branch" ]; then
        echo "($branch) "
    fi
}

# Prompt

PS1='\[\033[01;32m\][\u@\h]\[\033[00m\] >>> \[\033[01;34m\]\w\[\033[00m\] \[\033[01;33m\]$(git_branch)\[\033[00m\]\n\[\033[01;90m\]\A\[\033[00m\] $ '

# Listing
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'
alias l='ls -CF'

# Safety nets
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Shortcuts
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'

# Git shortcuts (if you use git)
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Fzf
alias efzf='emacsclient -tty $(fzf -m --preview="cat {}")'
alias nfzf='nvim $(fzf -m --preview="cat {}")'

export EDITOR=emacs
export VISUAL=emacs

# Add your custom PATH modifications below:
export PATH="$HOME/.local/bin:$PATH"

# Doom
export PATH="$HOME/.config/emacs/bin:$PATH"
