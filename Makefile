#!/usr/bin/make -f
# -*- coding:utf-8 -*-

DESTDIR?=~

BASE=$(DESTDIR)/usr/share/arco-tools
YASNIPPET=$(DESTDIR)/usr/share/emacs/site-lisp/yasnippet/snippets/text-mode
EMACS=$(DESTDIR)/usr/share/arco-tools/emacs

WGET=wget --no-check-certificate -nv

all:
	find config -name "*.cfg.el" | awk '{print "(byte-compile-file \"" $$1 "\")";}' > compile.el
	/usr/bin/emacs -batch -l compile.el -kill

clean:
	$(RM) $(shell find -name *~)
	find . -name "*.elc" -delete
	$(RM) compile.el

install:
	install -vd $(BASE)

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

	install -vm 444 config/schemas.xml $(EMACS)/

	install -vd $(EMACS)/template
	install -vm 444 template/* $(EMACS)/template/
