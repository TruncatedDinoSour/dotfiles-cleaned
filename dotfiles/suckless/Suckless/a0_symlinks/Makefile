include config.mk

install: version
	-ln -s "/usr/lib/llvm/$(CLANG_VERSION)/bin/clang" '/usr/bin/clang'
	-ln -s "/usr/lib/llvm/$(CLANG_VERSION)/bin/clang++" '/usr/bin/clang++'
	-ln -s "/usr/lib/llvm/$(CLANG_VERSION)/bin/llvm-strip" '/usr/bin/llvm-strip'

clean:
	@echo 'No cleaning step required'

version:
	@echo "Clang version $(CLANG_VERSION)"

