#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
alias dots='/usr/bin/git --git-dir=/home/tlsfbwls/.dotfiles/ --work-tree=/home/tlsfbwls'
