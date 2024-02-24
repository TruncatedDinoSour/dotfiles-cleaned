all: dfetch

clean:
	rm -f -- dfetch

dfetch: src/main.c
	./build.sh

install: dfetch
	./build.sh -i
	rm -f -- dfetch

uninstall:
	./build.sh -u
	rm -f -- dfetch
