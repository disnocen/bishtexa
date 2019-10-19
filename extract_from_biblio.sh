#! /bin/bash 
BIBFILE=$HOME/bibfile.bib
GREP_OPT="-A3 -B8"
#extraction=$(less $BIBFILE| grep -e title -e "abstract.*\}"|sed -e s/title\ \=// -e s/title\=// -e s/abstract\=// -e s/\{// -e s/\}// -e s/,//|fzf)
extraction=$(less $BIBFILE| grep -e title -e "abstract.*\}"|fzf| cut -c 1-300)
ref=$(grep $GREP_OPT "$extraction" $BIBFILE |grep \@|grep -o "{.*,"|sed -e s/\{// -e s/,//)
echo -n $ref|xclip -selection clipboard
echo -n $ref|xsel -b
#echo $ref

