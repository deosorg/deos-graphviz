include .deosrc

all:
	@-python main.py
	@-dot -Tpng var/dot/g.dot > var/img/g.png
