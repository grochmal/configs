# Makefile to create soft links for each configuration file/directory

# The minimum size for a variable (actually command line) according to POSIX is
# 4096 bytes.  That's about 50 lines of 80 characters each, if we are close to
# that limit we will need to add more rules.
LINKS = profile bashrc bash_profile\
        dir_colors mailcap screenrc gdbinit\
        xinitrc xsession Xresources Xmodmap xmobarrc stalonetrayrc\
        bin xmonad weechat
        # vifm
# TODO
XDG   = zathura
ENC   = procmailrc fetchmailrc muttrc\
        siggrochmal sigvalentine sigwork\
        abook ssh
ENCND = notes
HIST  = bash_history lesshst viminfo\
        wget-hsts
# TODO
XDGHS = pavucontrol.ini

all: pub links

pub:
	ln -fns pubrc rc

sec:
	ln -fns secrc rc

links:
	for link in $(LINKS); do \
	    echo ln -fns ~/rc/$${link} ~/.$${link}; \
	    ln -fns ~/rc/$${link} ~/.$${link}; \
	done
	for enc in $(ENC); do \
	    echo ln -fns ~/rc/rc/$${enc} ~/.$${enc}; \
	    ln -fns ~/rc/rc/$${enc} ~/.$${enc}; \
	done
	for enc in $(ENCND); do \
	    echo ln -fns ~/rc/rc/$${enc} ~/$${enc}; \
	    ln -fns ~/rc/rc/$${enc} ~/$${enc}; \
	done
	if ! test -d ~/.config; then \
	    echo mkdir ~/.config; \
	    mkdir ~/.config; \
	fi
#	for xdg in $(XDG); do \
#	    echo ln -fns ~/rc/$${xdg} ~/.config/$${xdg}; \
#	    ln -fns ~/rc/$${xdg} ~/.config/$${xdg}; \
#	done

ssd:
	for hist in $(HIST); do \
	    echo ln -fns /dev/null ~/.$${hist}; \
	    ln -fns /dev/null ~/.$${hist}; \
	done

clean:
	for link in $(LINKS); do \
	    if test -L ~/.$${link}; then \
	        echo rm -f ~/.$${link}; \
	        rm -f ~/.$${link}; \
	    fi; \
	done
	for enc in $(ENC); do \
	    if test -L  ~/.$${enc}; then \
	        echo rm -f ~/.$${enc}; \
	        rm -f ~/.$${enc}; \
	    fi; \
	done
	for enc in $(ENCND); do \
	    if test -L  ~/$${enc}; then \
	        echo rm -f ~/$${enc}; \
	        rm -f ~/$${enc}; \
	    fi; \
	done
	for hist in $(HIST); do \
	    if test -L ~/.$${hist}; then \
	        echo rm -f ~/.$${hist}; \
	        rm -f ~/.$${hist}; \
	    fi; \
	done

.PHONY: all pub sec links ssd clean

