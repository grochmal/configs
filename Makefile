# Makefile to create soft links for each configuration file/directory

LINKS = bashrc profile vimrc\
        xinitrc Xresources xsession
      # vifm xmonad Xresources
ENC   = abook procmail fetchmail muttrc
HIST  = bash_history lesshst viminfo

all: links

links:
	for link in $(LINKS); \
	do \
	  echo ln -fns ~/rc/$${link} ~/.$${link}; \
	  ln -fns ~/rc/$${link} ~/.$${link}; \
	done
	for enc in $(ENC); \
	do \
	  echo ln -fns ~/rc/rc/$${enc} ~/.$${enc}; \
	  ln -fns ~/rc/rc/$${enc} ~/.$${enc}; \
	done

ssd:
	for hist in $(HIST); \
	do \
	  echo ln -fns /dev/null ~/.$${hist}; \
	  ln -fns /dev/null ~/.$${hist}; \
	done

clean:
	for link in $(LINKS); \
	do \
	  if test -L ~/.$${link}; \
	  then \
	    echo rm -f ~/.$${link}; \
	    rm -f ~/.$${link}; \
	  fi; \
	done
	for enc in $(ENC); \
	do \
	  if test -L  ~/.$${enc}; \
	  then \
	    echo rm -f ~/.$${enc}; \
	    rm -f ~/.$${enc}; \
	  fi; \
	done
	for hist in $(HIST); \
	do \
	  if test -L ~/.$${hist}; \
	  then \
	    echo rm -f ~/.$${hist}; \
	    rm -f ~/.$${hist}; \
	  fi; \
	done

pub:
	ln -fns pubrc rc

sec:
	ln -fns secrc rc

.PHONY: all links ssd clean pub sec

