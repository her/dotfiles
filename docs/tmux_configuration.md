# tmux configurations 🚑

## Why Pasteboard Breaks

Quoted from ChrisJohnsen's tmux-MacOSX-pasteboard readme: 

>Access to the Mac OS X Pasteboard Service

>The pasteboard service in Mac OS X is registered in a "bootstrap namespace" (see Apple’s TN2083). The namespaces exist in a hierarchy: “higher” namespaces include access to “lower” namespaces. A process in a lower namespace can not access higher namespaces. So, all process can access the lowest, “root” bootstrap namespace, but only processes in a higher namespace can access that namespace. Processes created as a part of a Mac OS X login session are automatically included in the user’s “per-user” bootstrap namespace. The pasteboard service is only available to processes in the per-user bootstrap namespace.

>Interaction with tmux

>tmux uses the daemon(3) library function when starting its server process. In Mac OS X 10.5, Apple changed daemon(3) to move the resulting process from its original bootstrap namespace to the root bootstrap namespace. This means that the tmux server, and its children, will automatically and uncontrollably lose access to what would have been their original bootstrap namespace (i.e. the one that has access to the pasteboard service).


## How do we fix it?

Three packages are required to fix pbcopy when using tmux and terminal.app:
* [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
* [tmux-yank](https://github.com/tmux-plugins/tmux-yank)
* [tmux-MacOSX-pasteboard](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard)


