PROJECT = yafetch
CFLAGS := -Ofast -march=native -ffast-math -pipe -fno-asm -ansi -std=c11 -faggressive-loop-optimizations -floop-strip-mine -fno-omit-frame-pointer -fno-align-functions -fno-align-loops -fprofile-use -flto -fdce -free -funsafe-math-optimizations
LDFLAGS := -Wl,--gc-sections,-strip-all -flto -Ofast $(shell pkg-config --libs lua5.1)
OBJECTS = src/script.o src/func.o src/main.o

CONF = "/home/${USER}/.config/yafetch"
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin


all: $(OBJECTS)
	-rm -fv ./${PROJECT}
	gcc ${CFLAGS} $^ ${LDFLAGS} -o ${PROJECT}

config: ${PROJECT}
	mkdir -p ${CONF}
	cp init.lua ${CONF}/init.lua

install: ${PROJECT}
	mkdir -p ${BINDIR}
	install -Dm755 yafetch ${BINDIR}

clean:
	rm -fv ${PROJECT} ${OBJECTS}

