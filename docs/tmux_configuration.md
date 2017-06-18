# tmux configurations 🚑

## Why Pasteboard Breaks

Quoted from [ChrisJohnsen's tmux-MacOSX-pasteboard](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard) readme: 

>**Access to the Mac OS X Pasteboard Service**
>
>_The pasteboard service in Mac OS X is registered in a "bootstrap namespace" (see Apple’s TN2083). The namespaces exist in a hierarchy: “higher” namespaces include access to “lower” namespaces. A process in a lower namespace can not access higher namespaces. So, all process can access the lowest, “root” bootstrap namespace, but only processes in a higher namespace can access that namespace. Processes created as a part of a Mac OS X login session are automatically included in the user’s “per-user” bootstrap namespace. The pasteboard service is only available to processes in the per-user bootstrap namespace._
>
>**Interaction with tmux**
>
>_tmux uses the daemon(3) library function when starting its server process. In Mac OS X 10.5, Apple changed daemon(3) to move the resulting process from its original bootstrap namespace to the root bootstrap namespace. This means that the tmux server, and its children, will automatically and uncontrollably lose access to what would have been their original bootstrap namespace (i.e. the one that has access to the pasteboard service)._

## How do we fix it?
Three packages are required to fix pbcopy when using tmux and terminal.app:
* [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
* [tmux-yank](https://github.com/tmux-plugins/tmux-yank)
* [tmux-MacOSX-pasteboard](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard)

### Tmux Plugin Manager
Create two new directories for TPM (Tmux Plugin Manager)
`~/.tmux/plugins/`

Then clone TPM
`$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

Configure boilerplate for TPM in `~/.tmux.conf`
```shell
# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```

Now you can begin adding plugins to `~/.tmux.conf`, starting with TPM itself.
```shell
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
```
**Installing**, **Uninstalling**, and **Updating** plugins is done within tmux using the following commands:

Install:
`prefix` + <kbd>I</kbd> 

Update:
`prefix` + <kbd>U</kbd>

Uninstall:
`prefix` + <kbd>u</kbd>

### tmux-yank
Add the plugin to `~/.tmux.conf`

`set -g @plugin 'tmux-plugins/tmux-yank'`

Then install from within tmux using TPM's install hotkey

`prefix` + <kbd>I</kbd>

### tmux-MacOSX-pasteboard 
`brew install reattach-to-user-namespace`

Then add the following to your `~/.tmux.conf`

`set-option -g default-command "reattach-to-user-namespace -l $SHELL"`

### Finally! How do we use this new functionality?

Copy command line text to the clipboard: 
`prefix` + <kbd>y</kbd>

Copy the current working directory: 
`prefix` + <kbd>Y</kbd>

Copying text within Vim is the same process as normal. Once text selection is
highlighted in visual mode `"*y` will add it to the clipboard

**That's it! Congratulations on your overly configured .tmux.conf** 😅

### Notes

This works with tmux 2.5 Be sure to check future change logs before updating
tmux... Lest you find yourself scouring the net again trying to fix your copy
paste.

An easier solution if this sounds like too much work (and it is, let's be
honest) is to use iTerm2. Details on that are in the actual tmux-yank readme. 

Cheers 🍻 
