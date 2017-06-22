include .deosrc

all: venv
	$(MAKE) run

run:
	@-source $(DOTVENV)/bin/activate && cd src && python main.py
	@-dot -Tpng var/dot/g.dot > var/img/g.png

venv:
	@-$(RM) $(DOTVENV)
	@-mkdir $(DOTVENV)
	@-virtualenv --always-copy --no-site-packages $(DOTVENV)
	@-source $(DOTVENV)/bin/activate && pip install -r etc/python/requirements.txt

wiki.pull:
	@-$(RM) var/wiki
	@-cd var && git $(GITCLONE) $(GITWIKI) wiki
	@-$(RM) var/wiki/.git

wiki.push:
	@-$(RM) $(DOTSWAP)
	@-mkdir $(DOTSWAP)
	@-cd $(DOTSWAP) && $(GITCLONE) $(GITWIKI) wiki
	@-$(RM) $(SWAPWIKI)/*.md
	@-cp $(SWAPWIKI)/*.md $(SWAPWIKI)/
	@-cd $(SWAPWIKI) && $(GITADD) && $(GITCOMMIT) "$(WIKIMSG)" && $(GITPUSH)
	@-$(RM) $(DOTSWAP)
