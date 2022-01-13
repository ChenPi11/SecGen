#!/bin/zsh
SALT=`date +%N`
if [[ ARGC -gt 0 ]] then
  BINNAME=`basename $PWD`
  foreach USER ($@)
    mkdir -p obj/$USER
    AA=`echo $USER $SALT $BINNAME | openssl dgst -sha512 | awk '{print $2}' | cut -c 1-8`
    cat program.c.template | sed s/AAAAAA/$AA/ >! program.c
    gcc -o obj/$USER/$BINNAME program.c
  end
else
  echo "USAGE: build.zsh <user_email(s)>"
fi
