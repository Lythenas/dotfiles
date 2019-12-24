#!/bin/sh

case ${MONS_NUMBER} in
    1)
        mons -o
        ;;
    2)
        mons -e top
        ;;
    *)
        notify-send --expire-time=0 "More than 3 monitors connected" "Configure them manually"
        ;;
esac
