#!/bin/bash
umask 022

removeFromPath() {
  export PATH=$(echo "$PATH" | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

bash_setup() {
  # go setup
  export GOPATH=$HOME/go
  export GOROOT=/usr/local/opt/go/libexec

  # PATH should search my stuff, then local stuff, then system
  removeFromPath "${HOME}/bin"
  removeFromPath "/usr/local/bin"
  removeFromPath "/usr/local/sbin"
  export PATH="${HOME}/bin:/usr/local/bin:/usr/local/sbin:$GOPATH/bin:$GOROOT/bin:$PATH"

  # if shell flags ${-} have interactive flag "i"
  # Mac default flags are "himBH" which makes for a decent google search
  # ref: http://www.chainsawonatireswing.com/2012/02/02/find-out-what-your-unix-shells-flags-are-then-change-them/
  test -n "${-//[^i]/}" && bash_interactive_setup
}

bash_interactive_setup() {
  # -X: do not reset the terminal on exit, leave man page for reading
  export LESS="-FRSX"

  # better history options
  HISTSIZE=32768
  HISTFILESIZE=$HISTSIZE
  HISTCONTROL=ignoreboth  # dupes and starts-with-space
  shopt -s histappend

  alias lf="ls -GAF"
  alias ll="ls -al"

  alias findroot="sudo find / -path /Volumes -prune -o -path /dev -prune -o"

  alias gc="git commit"
  alias gs="git status"
  # log local branch changes:
  alias gl="git log --no-merges master.."

  alias GET="curl -so -"
  alias fetch="GET"

  #source ~/AWS/my/start.sh

  java_setjdk 1.8

  # node version management
  export NVM_DIR=~/.nvm
  source "$(brew --prefix nvm)"/nvm.sh

  # bash completion
  source "$(brew --prefix)/etc/bash_completion"

  # setup the prompt
  source ~/bin/set_ps1
}

ga() {
  # the default git behavior I want:
  # add everything if nothing is specified
  # always go to the commit editor
  all=
  test -z "$@" && all="--all ."
  git add $all "$@"
  git commit
}

gbranch() {
  git checkout -b $1 &&
  git push -u origin $1
}

gcd() {
  # cd to top level directory + optional folder
  path=$( git rev-parse --show-cdup 2>/dev/null )
  test $? -eq 0 -a -n "$path$1" && cd "$path$1"
}

vimwith() {
  vim -c "/${!#}" $( sgrep -l "$@" )
}

rvimwith() {
  rvim -c "/${!#}" $( sgrep -l "$@" )
}

# java management:
java_setjdk() {
  echo "java_setjdk $1"
  test -n "$JAVA_HOME" && removeFromPath "${JAVA_HOME}/bin"
  export JAVA_HOME=$( /usr/libexec/java_home -v "$@" )
  export PATH=${PATH}:${JAVA_HOME}/bin
  java -version 2>&1 | head -1
}

java_listjdks() {
  /usr/libexec/java_home -V
}

bash_setup

test -e ~/.bashrc_local && source ~/.bashrc_local
