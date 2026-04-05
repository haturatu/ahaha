.PHONY: all clean install

BINNAME?=ahaha

platform := $(shell uname -s)

PREFIX?=/usr/local
DATAROOTDIR?=$(PREFIX)/share
MANDIR?=$(DATAROOTDIR)/man

INSTALL?=install -p
MD=mkdir
BINMODE?=0755
MANMODE?=644

CFLAGS += -std=c99 -Wall -Wextra

all: $(BINNAME)

$(BINNAME): aha.c
	$(CC) $(CFLAGS) $(LDFLAGS) $(CPPFLAGS) aha.c -o $@

clean:
	rm -f $(BINNAME) aha

install: $(BINNAME)
ifeq ($(platform), Darwin)
	$(MD) -p $(DESTDIR)$(PREFIX)/bin/
	$(MD) -p $(DESTDIR)$(MANDIR)/man1/
	$(INSTALL) -m $(BINMODE) $(BINNAME) $(DESTDIR)$(PREFIX)/bin/$(BINNAME)
	$(INSTALL) -m $(MANMODE) aha.1 $(DESTDIR)$(MANDIR)/man1/$(BINNAME).1
else 
	$(INSTALL) -D -m $(BINMODE) $(BINNAME) $(DESTDIR)$(PREFIX)/bin/$(BINNAME)
	$(INSTALL) -D -m $(MANMODE) aha.1 $(DESTDIR)$(MANDIR)/man1/$(BINNAME).1
endif
