include .deosrc

all: venv
	$(MAKE) run

run:
	@-$(ACTVENV) && $(CD) src && $(PY) main.py
	@-dot -Tpng var/dot/g.dot > var/img/g.png

venv:
	@-$(RM) $(DOTVENV)
	@-$(MKDIR) $(DOTVENV)
	@-$(VENV) $(DOTVENV)
	@-$(ACTVENV) && $(PIPINSTALL) -r $(PYREQ)

wiki.pull:
	@-$(RM) $(VARWIKI)
	@-$(CD) $(VAR) && $(GITCLONE) $(GITWIKI) wiki
	@-$(RM) $(VARWIKI)/.git

wiki.push:
	@-$(RM) $(DOTSWAP)
	@-$(MKDIR) $(DOTSWAP)
	@-$(CD) $(DOTSWAP) && $(GITCLONE) $(GITWIKI) wiki
	@-$(RM) $(SWAPWIKI)/*.md
	@-$(CP) $(SWAPWIKI)/*.md $(SWAPWIKI)/
	@-cd .swap/wiki && mkdir img
	@-cp -a var/wiki/img/. .swap/wiki/img/
	@-$(CD) $(SWAPWIKI) && $(GITADD) && $(GITCOMMIT) "$(WIKIMSG)" && $(GITPUSH)
	@-$(RM) $(DOTSWAP)
