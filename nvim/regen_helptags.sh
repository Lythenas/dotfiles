#!/bin/sh

for d in $(ls .local/share/nvim/site/pack/plugins/start)
do
    docdir=".local/share/nvim/site/pack/plugins/start/$d/doc"

    [ -d "$docdir" ] && nvim -c "helptags $docdir|q"
done
