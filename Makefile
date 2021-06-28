all:
	@echo "usage:"
	@echo "    make [tea|git|food]"
	@echo -en "\n"
	@echo " TEA:"
	@echo "    Transfer and update dotfiles."
	@echo " GIT:"
	@echo "    Push dotfiles to github."
	@echo " FOOD:"
	@echo "    Install dotfiles."


tea:
	@/bin/chmod a+rx scripts/transfer.sh
	@./scripts/transfer.sh

git:
	@/bin/chmod a+rx scripts/git.sh
	@./scripts/git.sh

food:
	@/bin/chmod a+rx scripts/install.sh
	@./scripts/install.sh

water:
	@/bin/cat scripts/water.txt


install: food

