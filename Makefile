include .deosrc

all: venv
	$(MAKE) run

run:
	@-source $(DOTVENV)/bin/activate && cd src && python main.py
	@-dot -Tpng var/dot/g.dot > var/img/g.png

venv:
	@-rm -rf $(DOTVENV)
	@-mkdir $(DOTVENV)
	@-virtualenv --always-copy --no-site-packages $(DOTVENV)
	@-source $(DOTVENV)/bin/activate && pip install -r etc/python/requirements.txt

wiki.pull:
	@-rm -rf var/wiki
	@-cd var && git clone $(GITWIKI) wiki
	@-rm -rf var/wiki/.git

wiki.push:
	@-rm -rf $(DOTSWAP)
	@-mkdir $(DOTSWAP)
	@-cd $(DOTSWAP) && $(GITCLONE) $(GITWIKI) wiki
	@-rm -rf $(SWAPWIKI)/*.md
	@-cp $(SWAPWIKI)/*.md $(SWAPWIKI)/
	@-cd $(SWAPWIKI) && $(GITADD) && $(GITCOMMIT) "$(WIKIMSG)" && $(GITPUSH)
	@-rm -rf $(DOTSWAP)
