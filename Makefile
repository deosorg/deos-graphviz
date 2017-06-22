include .deosrc

all:
	@-python main.py
	@-dot -Tpng var/dot/g.dot > var/img/g.png

venv:
	@-rm -rf $(DOTVENV)
	@-mkdir $(DOTVENV)
	@-virtualenv --always-copy --no-site-packages $(DOTVENV)
