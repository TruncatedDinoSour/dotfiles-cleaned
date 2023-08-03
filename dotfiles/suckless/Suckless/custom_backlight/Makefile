backlight:
	fasm src/main.asm
	mv src/main backlight
	llvm-strip backlight --strip-debug --strip-sections --strip-unneeded -T --remove-section=.note.gnu.gold-version --remove-section=.note --strip-all --discard-locals --remove-section=.gnu.version --remove-section=.eh_frame --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag --strip-symbol=__gmon_start__ --strip-all-gnu --remove-section=.comment --remove-section=.eh_frame_ptr --discard-all
	chown root:root backlight
	chmod 4111 backlight

clean:
	rm -f backlight

install: backlight
	mkdir -p /usr/local/bin
	mv backlight /usr/local/bin
