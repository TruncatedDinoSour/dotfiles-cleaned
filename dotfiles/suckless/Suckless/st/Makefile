# st - simple terminal
# See LICENSE file for copyright and license details.
.POSIX:

include config.mk

SRC = st.c x.c
OBJ = $(SRC:.c=.o)

all: options st

options:
	@echo st build options:
	@echo "CFLAGS    = $(STCFLAGS)"
	@echo "LDFLAGS   = $(STLDFLAGS)"
	@echo "CC        = $(CC)"
	@echo "STRIP     = ${STRIP}"
	@echo "STFLAGS   = ${STRIPFLAGS}"

config.h:
	cp config.def.h config.h

.c.o:
	$(CC) $(STCFLAGS) -c $<

st.o: config.h st.h win.h
x.o: arg.h config.h st.h win.h

$(OBJ): config.h config.mk

st: $(OBJ)
	$(CC) -o $@ $(OBJ) $(STLDFLAGS)
	$(STRIP) $@ -o $@ ${STRIPFLAGS}

clean:
	rm -f st $(OBJ) st-$(VERSION).tar.gz

dist: clean
	mkdir -p st-$(VERSION)
	cp -R FAQ LEGACY TODO LICENSE Makefile README config.mk\
		config.def.h st.info st.1 arg.h st.h win.h $(SRC)\
		st-$(VERSION)
	tar -cf - st-$(VERSION) | gzip > st-$(VERSION).tar.gz
	rm -rf st-$(VERSION)

install: st
	cp -f config.h config.def.h
	mkdir -p $(DESTDIR)$(PREFIX)/bin $(DESTDIR)/usr/bin $(DESTDIR)$(PREFIX)/share/applications\
		$(DESTDIR)$(MANPREFIX)/man1
	cp -f st $(DESTDIR)$(PREFIX)/bin
	cp -f st $(DESTDIR)/usr/bin/xterm
	cp -f st-copyout st-copyline st-copylines\
		$(DESTDIR)$(PREFIX)/bin
	cp -f st.desktop $(DESTDIR)$(PREFIX)/share/applications
	chmod 755 $(DESTDIR)$(PREFIX)/bin/st $(DESTDIR)$(PREFIX)/bin/st-copyout\
		$(DESTDIR)$(PREFIX)/bin/st-copyline $(DESTDIR)$(PREFIX)/bin/st-copylines
	sed "s/VERSION/$(VERSION)/g" < st.1 > $(DESTDIR)$(MANPREFIX)/man1/st.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/st.1
	tic -sx st.info
	@echo Please see the README file regarding the terminfo entry of st.

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/st\
		/usr/bin/xterm\
		$(DESTDIR)$(PREFIX)/bin/st-copyout\
		$(DESTDIR)$(PREFIX)/bin/st-copyline\
		$(DESTDIR)$(PREFIX)/bin/st-copylines\
		$(DESTDIR)$(MANPREFIX)/man1/st.1

.PHONY: all options clean dist install uninstall
