git:
	-git add -A
	git commit -sam "update @ $(shell date)"
	-git push -u origin archlinux

tea:
	chmod u+rx ./scripts/*
	./scripts/transfer.sh
