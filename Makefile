# Makefile to create soft links for each configuration file

LINKS = bashrc profile vimrc # vifm xmonad Xresources
ENC   = abook procmail fetchmail muttrc
HIST  = bash_history lesshst viminfo

all: links

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
	  if [ -L ~/.$${link} ]; then \
	    echo rm -f ~/.$${link}; \
	    rm -f ~/.$${link}; \
	  fi; \
	done
	for enc in $(ENC); do \
	  if [ -L  ~/.$${enc} ]; then \
	    echo rm -f ~/.$${enc}; \
	    rm -f ~/.$${enc}; \
	  fi; \
	done
	for hist in $(HIST); do \
	  if [ -L ~/.$${hist} ]; then \
	    echo rm -f ~/.$${hist}; \
	    rm -f ~/.$${hist}; \
	  fi; \
	done

.PHONY: all links ssd clean

