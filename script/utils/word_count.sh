#/bin/bash

if ! [[ -f out/zjuthesis.fls ]]; then
    echo "Cannot find file 'out/zjuthesis.fls', which is generated by latexmk"
    echo "Please use 'latexmk' command to compile zjuthesis first, then run"
    echo "  this script in project root dir to count words"
    exit 1
fi

cat out/zjuthesis.fls                 \
    | uniq                            \
    | grep body                       \
    | grep .tex                       \
    | grep -v thanksto.tex            \
    | grep -v acknowledgement.tex     \
    | grep -v original.tex            \
    | grep -v cv.tex                  \
    | cut -d ' ' -f 2                 \
    | awk '{ print "\\input{"$1"}" }' \
    > out/zjuthesis.wordcnt           \
;

texcount out/zjuthesis.wordcnt -inc
