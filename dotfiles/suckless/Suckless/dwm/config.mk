# dwm version
VERSION = 6.3

# Customize below to fit your system

# paths
PREFIX = /usr/local
MANPREFIX = ${PREFIX}/share/man

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

# Xinerama, comment if you don't want it
XINERAMALIBS  = -lXinerama
XINERAMAFLAGS = -DXINERAMA

# freetype
FREETYPELIBS = -lfontconfig -lXft
FREETYPEINC = /usr/include/freetype2
# OpenBSD (uncomment)
#FREETYPEINC = ${X11INC}/freetype2

# includes and libs
INCS = -I${X11INC} -I${FREETYPEINC}
LIBS = -L${X11LIB} -lX11 ${XINERAMALIBS} ${FREETYPELIBS}

# flags
CPPFLAGS = -ffunction-sections -fdata-sections -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_POSIX_C_SOURCE=200809L -DVERSION=\"${VERSION}\" ${XINERAMAFLAGS}
#CFLAGS   = -g -std=c99 -pedantic -Wall -O0 ${INCS} ${CPPFLAGS}
CFLAGS   = -ffast-math -mfancy-math-387 -fno-ident -fmerge-all-constants -fno-unroll-loops -fno-math-errno -fno-unwind-tables -fno-asynchronous-unwind-tables -ffunction-sections -fdata-sections -std=c99 -pedantic -Wall -Wno-deprecated-declarations -Os ${INCS} ${CPPFLAGS}
LDFLAGS  = -Wl,--build-id=none -Wl,--hash-style=gnu -s ${LIBS}

# Solaris
#CFLAGS = -fast ${INCS} -DVERSION=\"${VERSION}\"
#LDFLAGS = ${LIBS}

# compiler and linker
CC = clang

# Stripper
STRIP = strip
STRIPFLAGS = --strip-all --remove-section=.eh_frame --remove-section=.eh_frame_ptr --remove-section=.note.gnu.gold-version --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag --remove-section=.note --remove-section=.gnu.version --remove-section=.comment --strip-debug --strip-unneeded

