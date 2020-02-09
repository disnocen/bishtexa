#! /usr/bin/zsh
# This script is to use in conjunction with the 
# createBiblio.sh script which will add the name of
# the file in the bibtex citation file.
#
# This is how it will give the file by opening it
#

editor=zathura
bibfile="$HOME/bibfile.bib"

# choose the article; it first lists all the articles, pass the list to fzf
# and then, after you chose one, it pass it to the citation script.
# then it take out the leading @
# It then search in the bibtex file the chosen article
# and then it outputs the file.
# finally it opens it with the pdf program
art=$(extract_from_biblio.sh)
echo "art is " $art
grep -A15 $art $bibfile| grep file
paper=$(grep -A15 $art $bibfile| grep file|grep -o "\{.*\}"|sed -e s/\{//g -e s/\}//g -e s/\n//|head -n1)
# paper=$(grep -A15 $art $bibfile| grep file|grep -o "\{.*\}"|sed -e s/\{//g -e s/\}//g -e s/\n//|head -n1|grep -o ".*pdf\:\/"|sed -e "s/\:\///")
echo "paper is" $paper
$editor "$(find /home/disnocen | fzf -q $paper)"





