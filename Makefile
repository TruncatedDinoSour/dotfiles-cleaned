git:
	-git add .
	-git commit -m "update @ $(shell date)"
	-git push -u origin gentoo

tea:
	chmod a+rx ./scripts/*
	./scripts/transfer.sh

tools:
	chmod a+rx ./scripts/tools.sh
	./scripts/tools.sh

