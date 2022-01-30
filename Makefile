git:
	-git add -A
	git commit -sam "update @ $(shell date)"
	-git push -u origin gentoo

tea:
	chmod u+rx ./scripts/*
	./scripts/transfer.sh

tools:
	chmod u+rx ./scripts/*
	./scripts/tools.sh

