# Interesting modifications to system files

Not everything on a system can be configured inside your home directory.
Notably, everything that happens before you login just can't know which home
directory you're actually going in.  Therefore notes on what things are nice to
modify are spread across these directories.

## xdm

I really like `xdm`, it ain't terribly unstable like `SliM` or impossible to
keep track of configuration like `GDM` or `KDM`.  May be clunky in the way how
fonts and resources are defined but that also makes you understand how Xorg
actually works.

## pacman

Since I'm mostly using Arch some notes on how to prevent `pacman` from
overriding the system files that you carefully changed is also in order.
Compared to huge package managers `pacman` is pretty simple to configure.  It
has that configuration file `/etc/pacman.conf` and the `/etc/pacman.d/`
directory containing the list of mirrors and GPG keys.

