# bishtexa
A bibtex management system in bash

## The Name
Given the scripts are in `bash` and they manage `bibtex` files, I decided to call the repository `bishtexa` because its pronounciation resembles the word *bistecca* (steak) in Italian.

## Goal
To create the most lightweight method to manage the bibliography for latex files. Without leaving the terminal.

## Motivation
All methods to manage the papers do too much. They:
- rename the paper (usualy with too many white spaces in the name...)
- manage the paper itself giving it an *ad hoc* location
- manage relative notes
- manage relative metadata (highlights, in-pdf notes,....)
- a cloud option
- provide you with an online account (obviously)
- other things you don't know
- write/export a bibtex file

This is in contrast with the UNIX principle. I tried to fix that.

## Content
I assume you have a consistent method to mangage the digital papers. For example by using *last_name_leading_author_date.pdf* method, as in *nakamoto08.pdf*. For this reason you only need an easy method to build your `bibliography.bib` file and an easy method to retreive the citation when you are writing the paper. Occasionally you can forget how you saved your paper, for this reason a third script `paper.sh` is provided.

There are three files:
- `createBiblio.sh` create a bib entry for a pdf; there is currently some manual work to do, mainly because pdfs have not the right metadata
- `extract_from_biblio.sh`: a `fzf` based script to select the paper you need to cite in a fuzzy way based on title and abstract
- `paper.sh`: another fzf based script to find the paper you want to read

## Dependencies

- Currently the bulk of the `bib` file is taken out of Google Scholar, thans to the (python) repository of [venthur](https://github.com/venthur/gscholar). I plan to find a substitute of google scholar and to do that in bash.
- `libpopper` is needed to convert from pdf to text in the `createBiblio.sh` script
- `fzf` is used to have the fuzzy choice
- `xsel` to copy to clipboard the citations

## Vim integration
I don't think there's a need for a vim plugin in this case, a simple one liner in the config file would do. I use

```
nnoremap <leader>m :!tmux split-pane -h 'extract_from_biblio.sh'<CR><CR>
```

(`extract_from_biblio` must be in your `PATH`). It copies to clipboard the citation so that you can simply paste it in you file. I use `tmux`, but you can use this one liner for a normal terminal (e.g. `urxvt`):

```
nnoremap <leader>m :!urxvt -x 'extract_from_biblio.sh'<CR><CR>
```

## TODO
- can we ditch google schoolar?
- aggregate the three script and do a self contained bash script with option, to be called `bishtexa.sh`
- an external config file
