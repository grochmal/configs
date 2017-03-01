#!/bin/sh
#
# ~/.xinitrc - must be executable (permissions)
#
# Executed by startx (run your window manager from here)

# check if the OS already have some scripts for us
if test -d /etc/X11/xinit/xinitrc.d
then
    for f in /etc/X11/xinit/xinitrc.d/*
    do
        test -x "$f" && source "$f"
    done
    unset f
fi

# set the keyboard map (gb is uk)
#setxkbmap gb
setxkbmap us

# we have a map so we can add xorg configuration in
if test -r "$HOME/.Xresources"
then
    xrdb "$HOME/.Xresources"
fi
if test -r "$HOME/.Xmodmap"
then
    xmodmap "$HOME/.Xmodmap"
fi

# mouse pointer for xmonad (xdm already does this for us)
#xsetroot -cursor_name left_ptr

# most of our configuration
xscreensaver -no-splash &

# urxvt has native transparency so we do not need this
#xcompmgr -c &

# java behaves badly in non-reparenting window managers (e.g. xmonad)
export _JAVA_AWT_WM_NONREPARENTING=1

# set the background (again, because qiv uses a different buffer)
feh=`which feh 2>/dev/null`
if test "x$feh" != "x" -a  -x "$feh" -a -e /usr/share/archlinux/wallpaper
then
    "$feh" --bg-scale --no-fehbg -z /usr/share/archlinux/wallpaper/a*.jpg
fi
unset feh

ibusd=`which ibus-daemon 2>/dev/null`
if test "x$ibusd" != "x" -a -x "$ibusd"
then
    "$ibusd" --daemonize --xim --desktop=xmonad
fi

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

