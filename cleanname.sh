#!/bin/bash
cd "$1"
pwd

function loop() {
    pwd
    for i in "$1"/*
    do
        if [ -d "$i" ]; then
            loop "$i"
        elif [ -e "$i" ]; then
            #echo "$i"
            format "$i"
        else
            echo "$i"" - Folder Empty"
        fi
    done
}

function format() {
    #echo "$1"
    completename=$1
    o_filename=$(basename "$completename" .txt)
    o_dir=$(dirname "$completename")
    echo $o_filename
    replace_with=
    n_filename="${o_filename/Songspk.LINK/$replace_with}"
    n_filename="${n_filename/Songspk.LIVE/$replace_with}"
    n_filename="${n_filename/Songspk.SITE/$replace_with}"
    n_filename="${n_filename//[[]]/$replace_with}"
    n_filename="${n_filename// ./.}"
    eyeD3 --remove-images "$completename"
    n_path=$o_dir"/"$n_filename
    if [ "$n_filename" != "$completename" ]; then
        echo "new path: " $n_path
        mv "$completename" "$n_path"
    fi
}


loop "$PWD"
