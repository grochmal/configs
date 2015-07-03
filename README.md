rc configs
==========

Repository containing snippets of configuration files for several tools.  Tools
like bash, vim, emacs, irssi (IRC client), mutt (email reader) commonly name
their configuration file with a suffix *rc* (which stands for "run commands").
The simplicity of *rc files* allows for easy of use but also allows for
security issues when such files are shared, e.g. if you share your .muttrc
you're also sharing your email address together with your name and the ID of
your PGP key.

This repository tries to address these security issues by either separating the
*rc files* into a public and a personal part or by creating example *rc files*
that can be shared without giving personal info.  If you have a well defined
division between *rc files* that contain personal information and ones that do
not, you can backup the *public rc files* publicly and the *personal rc files*
in a secure manner (e.g. on encrypted media).

The *root directory* contains files that can be easily made public, the `pubrc`
directory contains *examples* of *personal rc files*.  Whilst the `secrc`
directory shall contain personal versions of these files.  The `Makefile`
changes the `rc` softlink between `pubrc` and `secrc` and shall be used to
alternate between development and deployment of the *rc files*.  Finally, the
`media` directory contains arguments and scripts for other types of files you
might want to backup.  For example, in the `media` directory you will find best
practices for encoding of several types of media.

Copying
-------

Copyright (C) 2014-2015 Michal Grochmal

This file is an integral part of the configuration snippets.

All code snippets in this repository are free software; you can redistribute
and/or modify all or some of the snippets under the terms of the GNU General
Public License as published by the Free Software Foundation; either version 3
of the License, or (at your option) any later version.

The code snippets in this repository are distributed in the hope that they will
be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public
License for more details.

The COPYING file in the root directory of the project contains a copy of the
GNU General Public License. If you cannot find this file, see
<http://www.gnu.org/licenses/>.

