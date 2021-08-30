git:
	git add .
	git commit -m "update @ $(shell date)"
	git push -u origin gentoo

tea:
	chmod a+rx ./scripts/transfer.sh
	./scripts/transfer.sh

