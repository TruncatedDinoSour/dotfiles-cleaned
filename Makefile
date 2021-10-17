git:
	-git add .
	-git commit -m "update @ $(shell date)"
	-git push -u origin archlinux

tea:
	chmod a+rx ./scripts/transfer.sh
	./scripts/transfer.sh

tools:
	chmod a+rx ./scripts/tools.sh
	./scripts/tools.sh

