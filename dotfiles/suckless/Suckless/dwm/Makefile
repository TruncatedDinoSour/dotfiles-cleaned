# dwm - dynamic window manager
# See LICENSE file for copyright and license details.

include config.mk

SRC = drw.c dwm.c util.c
OBJ = ${SRC:.c=.o}

all: options dwm

options:
	@echo dwm build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

config.h:
	cp config.def.h $@

dwm: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	rm -f dwm ${OBJ} dwm-${VERSION}.tar.gz

dist: clean
	mkdir -p dwm-${VERSION}
	cp -R LICENSE Makefile README config.def.h config.mk\
		dwm.1 drw.h util.h ${SRC} dwm.png transient.c dwm-${VERSION}
	tar -cf dwm-${VERSION}.tar dwm-${VERSION}
	gzip dwm-${VERSION}.tar
	rm -rf dwm-${VERSION}

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	mkdir -p /usr/share/xsessions
	cp -f dwm ${DESTDIR}${PREFIX}/bin
	cp -f quitdwm ${DESTDIR}${PREFIX}/bin
	cp -f emoji ${DESTDIR}${PREFIX}/bin
	cp -f dwmlocker ${DESTDIR}${PREFIX}/bin
	cp -f send_calcurse_notification ${DESTDIR}${PREFIX}/bin
	cp -f redshifttoggle ${DESTDIR}${PREFIX}/bin
	cp -f dwm.desktop /usr/share/xsessions
	chmod 755 ${DESTDIR}${PREFIX}/bin/dwm
	chmod 755 ${DESTDIR}${PREFIX}/bin/quitdwm
	chmod 755 ${DESTDIR}${PREFIX}/bin/emoji
	chmod 755 ${DESTDIR}${PREFIX}/bin/dwmlocker
	chmod 755 ${DESTDIR}${PREFIX}/bin/send_calcurse_notification
	chmod 755 ${DESTDIR}${PREFIX}/bin/redshifttoggle
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	sed "s/VERSION/${VERSION}/g" < dwm.1 > ${DESTDIR}${MANPREFIX}/man1/dwm.1
	chmod 644 ${DESTDIR}${MANPREFIX}/man1/dwm.1

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dwm\
		${DESTDIR}${MANPREFIX}/man1/dwm.1\
		${DESTDIR}${PREFIX}/bin/quitdwm\
		${DESTDIR}${PREFIX}/bin/emoji\
		${DESTDIR}${PREFIX}/bin/dwmlocker\
		${DESTDIR}${PREFIX}/bin/send_calcurse_notification\
		${DESTDIR}${PREFIX}/bin/redshifttoggle

.PHONY: all options clean dist install uninstall
