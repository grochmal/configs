# Makefile to create soft links for each configuration file/directory

# The minimum size for a variable (actually command line) according to POSIX is
# 4096 bytes.  That's about 50 lines of 80 characters each, if we are close to
# that limit we will need to add more rules.
LINKS = profile bashrc bash_profile
        #xinitrc xsession Xresources Xmodmap\
        #vifm xmonad
ENC   = procmailrc fetchmailrc muttrc\
        siggrochmal sigvalentine sigwork\
        abook ssh
HIST  = bash_history lesshst viminfo

all: pub links

pub:
	ln -fns pubrc rc

sec:
	ln -fns secrc rc

links:
	for link in $(LINKS); do \
	    echo ln -fs ~/rc/$${link} ~/.$${link}; \
	    ln -fs ~/rc/$${link} ~/.$${link}; \
	done
	for enc in $(ENC); do \
	    echo ln -fs ~/rc/rc/$${enc} ~/.$${enc}; \
	    ln -fs ~/rc/rc/$${enc} ~/.$${enc}; \
	done

ssd:
	for hist in $(HIST); do \
	    echo ln -fs /dev/null ~/.$${hist}; \
	    ln -fs /dev/null ~/.$${hist}; \
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
	for hist in $(HIST); do \
	    if test -L ~/.$${hist}; then \
	        echo rm -f ~/.$${hist}; \
	        rm -f ~/.$${hist}; \
	    fi; \
	done

.PHONY: all pub sec links ssd clean

