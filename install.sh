#!/bin/sh

IFS='
'

# install brew if needed

which -s brew || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew taps

tapifneeded() {
  brew tap | grep -qx "$1" || brew tap "$1"
}

taps="
dbrinegar/dbrinegar
homebrew/science
"

for tap in $taps
do
  tapifneeded "$tap"
done

# essential brew packages

brewifneeded() {
  brew list "$1" 2>/dev/null >/dev/null || brew install "$1"
}

brews="
bash-completion
ctags
dbrinegar/dbrinegar/gitutils
dnsmasq
jq
node
nvm
parallel
shellcheck
"

for b in $brews
do
  brewifneeded "$b"
done

# install home files

archive() {
  test -e "$1" || return

  base="../archives"

  if test -z "$ARCHIVE"
  then
    mkdir -p $base
    ARCHIVE=$( mktemp -d "$base/$( date +%F ).X" )
  fi

  mv -v "$1" "$ARCHIVE"
}

( cd home && for f in $( find . -type f )
do
  if ! diff -q $f ~/$f 2>/dev/null
  then
    archive ~/$f
    ln -v $f ~/$f
  fi
done )

