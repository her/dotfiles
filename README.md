# dotfiles🌲

### vimrc 🖤
Launch vim and vimrc will bootstrap itself.

### Notes 🤔

Monkey Patch vim json syntax file to stop concealment of json quotes.

```
open vim
:e $VIMRUNTIME/syntax/json.vim
:g/if has('conceal')/s//& \&\& 0/
:wq
```

🐳 Docker binds detach over `<C-e>` and `<C-p>`. To reverse this behavior
set a config within `.docker/config.json`

```
{
  "detachKeys": "ctrl-q,ctrl-q"
}
```
