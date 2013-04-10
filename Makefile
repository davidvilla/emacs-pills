#!/usr/bin/make -f
# -*- coding:utf-8 -*-

DESTDIR?=~

BASE=$(DESTDIR)/usr/share/arco
EMACS=$(DESTDIR)/usr/share/arco/emacs
YASNIPPET=$(DESTDIR)/usr/share/emacs/site-lisp/yasnippet/snippets/text-mode
DOCBOOK=http://www.oasis-open.org/docbook/rng/4.5

WGET=wget --no-check-certificate -nv

all:
	find config -name "*.cfg.el" | awk '{print "(byte-compile-file \"" $$1 "\")";}' > bytecompile.el
	/usr/bin/emacs -L modules -batch -l bytecompile.el -kill

clean:
	$(RM) $(shell find -name *~)
	find . -name "*.elc" -delete
	$(RM) compile.el

install:
	install -vd $(BASE)
	install -v -m 755 bin/* $(BASE)/

	install -vd $(YASNIPPET)
	install -v -m 444 yasnippet/text-mode/*.yasnippet $(YASNIPPET)/
	install -vd $(YASNIPPET)/python-mode
	install -v -m 444 yasnippet/text-mode/python-mode/*.yasnippet $(YASNIPPET)/python-mode/
	install -vd $(YASNIPPET)/ruby-mode
	install -v -m 444 yasnippet/text-mode/ruby-mode/*.yasnippet $(YASNIPPET)/ruby-mode/
	install -vd $(YASNIPPET)/latex-mode
	install -v -m 444 yasnippet/text-mode/latex-mode/*.yasnippet $(YASNIPPET)/latex-mode/

	install -vd $(EMACS)
	install -vm 444 config/*.cfg.elc $(EMACS)/
	install -vm 444 template.el $(EMACS)/
	install -vm 444 modules/*.el $(EMACS)/

	install -vm 444 config/schemas.xml $(EMACS)/
	@$(WGET) $(DOCBOOK)/docbook.rnc  -O $(EMACS)/docbook.rnc
	@$(WGET) $(DOCBOOK)/dbnotnx.rnc  -O $(EMACS)/dbnotnx.rnc
	@$(WGET) $(DOCBOOK)/dbpoolx.rnc  -O $(EMACS)/dbpoolx.rnc
	@$(WGET) $(DOCBOOK)/htmltblx.rnc -O $(EMACS)/htmltblx.rnc
	@$(WGET) $(DOCBOOK)/calstblx.rnc -O $(EMACS)/calstblx.rnc
	@$(WGET) $(DOCBOOK)/dbhierx.rnc  -O $(EMACS)/dbhierx.rnc

	install -vd $(EMACS)/template
	install -vm 444 template/* $(EMACS)/template/


gen-doc:
	$(MAKE) -C config
