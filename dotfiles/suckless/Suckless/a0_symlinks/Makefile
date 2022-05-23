include config.mk

clean:
	@echo 'No cleaning step required'

install: version
	-ln -s "/usr/lib/llvm/$(CLANG_VERSION)/bin/clang" '/usr/bin/clang'
	-ln -s "/usr/lib/llvm/$(CLANG_VERSION)/bin/clang++" '/usr/bin/clang++'

version:
	@echo "Clang version $(CLANG_VERSION)"

