# slock version
VERSION = 1.5

# Customize below to fit your system

# paths
PREFIX = /usr/local
MANPREFIX = ${PREFIX}/share/man

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

# includes and libs
INCS = -I. -I/usr/include -I${X11INC}
LIBS = -L/usr/lib -lc -lcrypt -L${X11LIB} -lX11 -lXext -lXrandr -lImlib2

# flags
CPPFLAGS = -ffunction-sections -fdata-sections -DVERSION=\"${VERSION}\" -D_DEFAULT_SOURCE -DHAVE_SHADOW_H -Ofast
CFLAGS = -Werror -Wshadow -Wall -Wextra -Wpedantic -pedantic -ffast-math -mfancy-math-387 -fno-ident -fmerge-all-constants -fno-unroll-loops -fno-math-errno -fno-unwind-tables -fno-asynchronous-unwind-tables -ffunction-sections -fdata-sections -std=c99 -pedantic -Wall -Ofast ${INCS} ${CPPFLAGS}
LDFLAGS = -Wl,--build-id=none -Wl,--hash-style=gnu,-Ofast,-flto -s ${LIBS}
COMPATSRC = explicit_bzero.c

# On OpenBSD and Darwin remove -lcrypt from LIBS
#LIBS = -L/usr/lib -lc -L${X11LIB} -lX11 -lXext -lXrandr
# On *BSD remove -DHAVE_SHADOW_H from CPPFLAGS
# On NetBSD add -D_NETBSD_SOURCE to CPPFLAGS
#CPPFLAGS = -DVERSION=\"${VERSION}\" -D_BSD_SOURCE -D_NETBSD_SOURCE
# On OpenBSD set COMPATSRC to empty
#COMPATSRC =

# compiler and linker
CC = clang

# Stripper
STRIP = llvm-strip
STRIPFLAGS = --strip-all --remove-section=.eh_frame --remove-section=.eh_frame_ptr --remove-section=.note.gnu.gold-version --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag --remove-section=.note --remove-section=.gnu.version --remove-section=.comment --strip-debug --strip-unneeded

