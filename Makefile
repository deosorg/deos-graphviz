include .deosrc

all: venv
	$(MAKE) run

run:
	@-source $(DOTVENV)/bin/activate && $(CD) src && python main.py
	@-dot -Tpng var/dot/g.dot > var/img/g.png

venv:
	@-$(RM) $(DOTVENV)
	@-$(MKDIR) $(DOTVENV)
	@-virtualenv --always-copy --no-site-packages $(DOTVENV)
	@-source $(DOTVENV)/bin/activate && pip install -r etc/python/requirements.txt

wiki.pull:
	@-$(RM) var/wiki
	@-$(CD) var && git $(GITCLONE) $(GITWIKI) wiki
	@-$(RM) var/wiki/.git

wiki.push:
	@-$(RM) $(DOTSWAP)
	@-$(MKDIR) $(DOTSWAP)
	@-$(CD) $(DOTSWAP) && $(GITCLONE) $(GITWIKI) wiki
	@-$(RM) $(SWAPWIKI)/*.md
	@-$(CP) $(SWAPWIKI)/*.md $(SWAPWIKI)/
	@-$(CD) $(SWAPWIKI) && $(GITADD) && $(GITCOMMIT) "$(WIKIMSG)" && $(GITPUSH)
	@-$(RM) $(DOTSWAP)
