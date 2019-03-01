#!/bin/bash

help="
script to copy folders to hoerbert

usage:
$0 <dir with music> <number on hoerbert(0-8)>
"

if (("$1"=="-h")); then
    echo "$help"
    exit
fi

dir=$1
target=$2
CARD="/media/seppobacho/3432-6530/"
startid=0

# check for target directory
if [ ! -d "$CARD/$target" ]; then
    mkdir $CARD/$target
else
    while true; do
        read -p "Target folder exists, (a)ppend, (o)verwrite or (c)cancel? " aoc
        case $aoc in
           [Aa]* ) startid=`ls $CARD/$target -1 | wc -l`; break;;
           [Oo]* ) rm -rf $CARD/$target/*; break;;
           [Ii]* ) break;;
           [Cc]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
fi

# copy
files=("$dir"/*)
endid=$(($startid+${#files[@]}))
for i in  $(seq $startid $((endid-1))) ; do
    fileid=$(($i-$startid))
    file=${files[$fileid]}
    echo "$i $file"
     sox --buffer 131072 --multi-threaded --no-glob "$file" --clobber -r 32000 -b 16 -e signed-integer --no-glob $CARD/$target/$i.WAV remix - gain -n -1.5 bass +1 loudness -1 pad 0 0 dither
done 
