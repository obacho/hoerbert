#!/bin/bash


dir=$1
target=$2
CARD="/media/seppobacho/3432-6530/"
intro="`dirname $0`/sounds/$target*.wav"
startid=1

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

#intro
if (($startid == 1)); then
    echo "adding intro $intro"
    sox --buffer 131072 --multi-threaded --no-glob $intro --clobber -r 32000 -b 16 -e signed-integer --no-glob $CARD/$target/0.WAV remix - gain -n -1.5 bass +1 loudness -1 pad 0 0 dither
fi

# copy
files=("$dir"/*)
endid=$(($startid+${#files[@]}))
for i in  $(seq $startid $endid) ; do
    fileid=$(($i-$startid))
    file=${files[$fileid]}
    echo "$i $file"
     sox --buffer 131072 --multi-threaded --no-glob "$file" --clobber -r 32000 -b 16 -e signed-integer --no-glob $CARD/$target/$i.WAV remix - gain -n -1.5 bass +1 loudness -1 pad 0 0 dither
done 
