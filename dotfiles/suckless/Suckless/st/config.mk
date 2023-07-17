# st version
VERSION = 0.9

# Customize below to fit your system

# paths
PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

PKG_CONFIG = pkg-config

# includes and libs
INCS = -I$(X11INC) \
       `$(PKG_CONFIG) --cflags fontconfig` \
       `$(PKG_CONFIG) --cflags freetype2`
LIBS = -L$(X11LIB) -lm -lrt -lX11 -lutil -lXft \
       `$(PKG_CONFIG) --libs fontconfig` \
       `$(PKG_CONFIG) --libs freetype2`

# flags
STCPPFLAGS = -ffunction-sections -fdata-sections -DVERSION=\"$(VERSION)\" -D_XOPEN_SOURCE=600
STCFLAGS = -Ofast -Werror -Wshadow -Wall -Wextra -Wpedantic -pedantic -ffast-math -mfancy-math-387 -fno-ident -fmerge-all-constants -fno-unroll-loops -fno-math-errno -fno-unwind-tables -fno-asynchronous-unwind-tables -ffunction-sections -fdata-sections $(INCS) $(STCPPFLAGS)
STLDFLAGS = -Wl,--build-id=none -Wl,--hash-style=gnu,-Ofast,-flto -s $(LIBS)

# OpenBSD:
#CPPFLAGS = -DVERSION=\"$(VERSION)\" -D_XOPEN_SOURCE=600 -D_BSD_SOURCE
#LIBS = -L$(X11LIB) -lm -lX11 -lutil -lXft \
#       `$(PKG_CONFIG) --libs fontconfig` \
#       `$(PKG_CONFIG) --libs freetype2`

# compiler and linker
CC = clang

# Stripper
STRIP = llvm-strip
STRIPFLAGS = --strip-all --remove-section=.eh_frame --remove-section=.eh_frame_ptr --remove-section=.note.gnu.gold-version --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag --remove-section=.note --remove-section=.gnu.version --remove-section=.comment --strip-debug --strip-unneeded

