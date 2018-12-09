#!/bin/bash

n_files=`ls [0-9]*.WAV | wc -l`
for i in $(seq $n_files -1 1); do 
    echo "shifting $((i-1)) -> $((i))"; 
    mv $((i-1)).WAV $((i)).WAV; 
done
