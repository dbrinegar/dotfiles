# dotfiles

personal dot files

./install.sh will do non-destructive updates, installing:
* brew
* a list of brew taps
* a list of brew packages
* everything in home/
* a list of brew packages

Running install.sh a second time should do nothing.  If you have any other version of the home/ content already it is moved into archives/ so you can restore or compare.
