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
fswatch
git
jq
node
nvm
parallel
shellcheck
vim
vimpager
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
    mkdir -pv $base
    ARCHIVE=$( mktemp -d "$base/$( date +%F ).X" )
  fi

  mv -v "$1" "$ARCHIVE"
}

(
  cd home || exit

  for d in $( find . -type d -mindepth 1 )
  do
    mkdir -pv ~/$d
  done

  for f in $( find . -type f )
  do
    if ! diff -q $f ~/$f 2>/dev/null
    then
      archive ~/$f
      ln -v $f ~/$f
    fi
  done
)

# vim bundles

bundle() {
  author="$1"
  package="$2"
  base=~/.vim/bundle

  mkdir -pv $base

  test -d $base/$package && return
  (
    cd $base
    git clone https://github.com/$author/$package
    if [ -n "$3" ]
    then
      $3
    fi
  )
}

post_install_command_t() {
  cd $package/ruby/command-t &&
  ruby extconf.rb &&
  make
}

bundle scrooloose  syntastic
bundle majutsushi  tagbar
bundle tpope       vim-dispatch
bundle fatih       vim-go
bundle juanpabloaj vim-istanbul
bundle elzr        vim-json
bundle tpope       vim-markdown
bundle derekwyatt  vim-scala
bundle tpope       vim-sensible
bundle wincent     Command-T      post_install_command_t
