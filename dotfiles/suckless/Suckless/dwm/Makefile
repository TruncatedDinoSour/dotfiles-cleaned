# dwm - dynamic window manager
# See LICENSE file for copyright and license details.

include config.mk

SRC = drw.c dwm.c util.c
OBJ = ${SRC:.c=.o}

all: options dwm

options:
	@echo dwm build options:
	@echo "CFLAGS    = ${CFLAGS}"
	@echo "LDFLAGS   = ${LDFLAGS}"
	@echo "CC        = ${CC}"
	@echo "STRIP     = ${STRIP}"
	@echo "STFLAGS   = ${STRIPFLAGS}"

.c.o:
	${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

config.h:
	cp config.def.h $@

dwm: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS}
	$(STRIP) $@ -o $@ ${STRIPFLAGS}

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
	cp -f config.h config.def.h
	mkdir -p ${DESTDIR}${PREFIX}/bin ${DESTDIR}${PREFIX}/share/xsessions ${DESTDIR}${MANPREFIX}/man1
	cp -f dwm quitdwm emoji dwmlocker send_calcurse_notification redshifttoggle\
		extrakb dweather dwmmenu fpdwm ${DESTDIR}${PREFIX}/bin
	cp -f dwm.desktop ${DESTDIR}${PREFIX}/share/xsessions
	chmod 755 ${DESTDIR}${PREFIX}/bin/dwm ${DESTDIR}${PREFIX}/bin/quitdwm\
		${DESTDIR}${PREFIX}/bin/emoji ${DESTDIR}${PREFIX}/bin/dwmlocker\
		${DESTDIR}${PREFIX}/bin/send_calcurse_notification\
		${DESTDIR}${PREFIX}/bin/redshifttoggle ${DESTDIR}${PREFIX}/bin/extrakb\
		${DESTDIR}${PREFIX}/bin/dweather ${DESTDIR}${PREFIX}/bin/dwmmenu\
		${DESTDIR}${PREFIX}/bin/fpdwm
	sed "s/VERSION/${VERSION}/g" < dwm.1 > ${DESTDIR}${MANPREFIX}/man1/dwm.1
	chmod 644 ${DESTDIR}${MANPREFIX}/man1/dwm.1

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dwm\
		${DESTDIR}${MANPREFIX}/man1/dwm.1\
		${DESTDIR}${PREFIX}/bin/quitdwm\
		${DESTDIR}${PREFIX}/bin/emoji\
		${DESTDIR}${PREFIX}/bin/dwmlocker\
		${DESTDIR}${PREFIX}/bin/send_calcurse_notification\
		${DESTDIR}${PREFIX}/bin/redshifttoggle\
		${DESTDIR}${PREFIX}/bin/extrakb\
		${DESTDIR}${PREFIX}/bin/dweather\
		${DESTDIR}${PREFIX}/bin/fpdwm

.PHONY: all options clean dist install uninstall
