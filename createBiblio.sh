#! /bin/bash

BIBFILE=$HOME/bibfile.bib

if [[ $(cat bibfile.bib|grep "$1") ]];then
    echo "eccolo"
    exit 0
else
    if [[ $# -gt 0 ]]; then
            title=$( pdfinfo "$1"|grep Title|sed -e s/Title\:// -e s/\ \ //g)
            author=$(pdfinfo "$1"|grep Author|sed -e s/Author\:// -e s/\ \ //g)

            echo "title: "$title
            echo "Is it ok?"
            read bool

            if [[ $bool == y ]]; then
                    echo "ottimo!"
            else
                    pdftotext -f 1 -l 1 "$1" - |sed /bstract/q|sed /BSTRACT/q
                    echo "Write new title"
                    read title
                    echo "ora è a posto!"
            fi

            echo "author: "$author
            echo "Is it ok?"
            read bool

            if [[ $bool == y ]]; then
                    echo "ottimo!"
            else
                    pdftotext -f 1 -l 1 "$1" - |sed /bstract/q|sed /BSTRACT/q
                    echo "Write new author"
                    read author
                    echo "ora è a posto!"
            fi
    else
            echo "Some words from the title and the author name, please"
            read title
            author=" "
    fi


    query="$title $author"
    echo "This is the query:"
    echo $query
    echo $query > .test

    echo "Is it ok?"
    read bool

    if [[ $bool == y ]];then
            query=$(cat .test)
            gscholar "$query "> bib.test
    else
            $EDITOR .test
            query=$(cat .test)
            gscholar "$query "> bib.test
    fi


    if [[ $# -gt 0 ]]; then
    # get the abstract
            abstract=$(pdftotext -f 1 -l 1 "$1" - | grep -i "abstract" -A6)
    else
            abstract=" "
    fi

    cat bib.test | sed s,^\},, > bib
    rm bib.test

    echo abstract\=\{"$abstract"\}\, >> bib
    echo file\=\{$1}>>bib
    echo \}>>bib

    cat bib

    echo "Is it good?"
    read bool

    if [[ $bool == y ]]; then
            echo "ottimo!"
    else
            vi bib
            echo "ora è a posto!"
    fi

    cat bib >> $BIBFILE
fi