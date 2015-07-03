#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if test -d /etc/X11/xinit/xinitrc.d
then
    for f in /etc/X11/xinit/xinitrc.d/*
    do
        [ -x "$f" ] && source "$f"
    done
    unset f
fi

# uk keyboard
setxkbmap gb

# mouse pointer for xmonad (xdm already does this)
#xsetroot -cursor_name left_ptr

# most of our configuretion
xrdb .Xresources
xscreensaver -no-splash &

# urxvt has native transparency so we do not need this
#xcompmgr -c &

# java behaves badly in non-reparenting window managers (e.g. xmonad)
export _JAVA_AWT_WM_NONREPARENTING=1

# set the background (again, because qiv uses a different buffer)
/usr/bin/feh --bg-scale --no-fehbg -z /usr/share/archlinux/wallpaper/a*.jpg

# pulse audio for alsa
if test -x /usr/bin/start-pulseaudio-x11
then
    /usr/bin/start-pulseaudio-x11
fi

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
exec xmonad

