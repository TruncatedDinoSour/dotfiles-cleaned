git:
	-git add -A
	-git commit -S -m "update @ $(shell date)"
	-git push -u origin gentoo

tea:
	chmod a+rx ./scripts/*
	./scripts/transfer.sh

tools:
	chmod a+rx ./scripts/*
	./scripts/tools.sh

