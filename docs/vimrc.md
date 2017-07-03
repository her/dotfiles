# .vimrc with annotations :blossom:

Documents the various configurations in my .vimrc for reference.

### Centralized Directory for all Swap, Backups, and Undo

Save all swap, backup, and undo to these locations. 

```sh
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
```
The trailing double slash `//` enables functionality that ensures each file
added to the directories will be unique, thereby preventing overwrites.

You do have to create these directories for the settings to work.

This code will make the directories automatically, handy for setting up new
environments

```vim
if !isdirectory($HOME . "/.vim/backup")
    call mkdir($HOME . "/.vim/backup", "p")
endif
if !isdirectory($HOME . "/.vim/swap")
    call mkdir($HOME . "/.vim/swap", "p")
endif
if !isdirectory($HOME . "/.vim/undo")
    call mkdir($HOME . "/.vim/undo", "p")
endif
```
