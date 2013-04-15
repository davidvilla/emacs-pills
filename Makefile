#!/usr/bin/make -f
# -*- coding:utf-8 -*-

DESTDIR?=~

BASE=$(DESTDIR)/usr/share/emacs-pills
OLDBASE=$(DESTDIR)/usr/share/arco/emacs
YASNIPPET=$(DESTDIR)/usr/share/emacs/site-lisp/yasnippet/snippets/text-mode
DOCBOOK=http://www.oasis-open.org/docbook/rng/4.5

WGET=wget --no-check-certificate -nv

all:
	make -C config

clean:
	$(RM) $(shell find -name *~)
	make -C config clean

install:
	install -vd $(BASE)
	install -vd $(OLDBASE)

	install -v -m 755 bin/* $(BASE)/

	install -vd $(YASNIPPET)
	install -v -m 444 yasnippet/text-mode/*.yasnippet $(YASNIPPET)/
	install -vd $(YASNIPPET)/python-mode
	install -v -m 444 yasnippet/text-mode/python-mode/*.yasnippet $(YASNIPPET)/python-mode/
	install -vd $(YASNIPPET)/ruby-mode
	install -v -m 444 yasnippet/text-mode/ruby-mode/*.yasnippet $(YASNIPPET)/ruby-mode/
	install -vd $(YASNIPPET)/latex-mode
	install -v -m 444 yasnippet/text-mode/latex-mode/*.yasnippet $(YASNIPPET)/latex-mode/

	install -vd $(BASE)
	install -vm 444 config/*.cfg.elc $(BASE)/
	install -vm 444 config/template.el $(BASE)/
	install -vm 444 modules/*.el $(BASE)/

	for i in $$(find config -name "*.cfg.el" -exec basename {} \;); do \
	    echo  "(message \"Deprecation warning: 'emacs-pills' is now at /usr/share/emacs-pills. Undate your .emacs\")\n(load \"/usr/share/emacs-pills/$${i}c\")" > $(OLDBASE)/$$i; \
	done

#	for i in $$(find config -name "*.cfg.el" -exec basename {} \;); do \
#	    echo  "(message \"Deprecation warning: 'emacs-pills' is now at /usr/share/emacs-pills. Undate your .emacs\")\n(add-to-ordered-list 'load-path \"/usr/share/emacs-pills\")\n(load \"$$i\")" > $(OLDBASE)/$$i; \
#	done


	install -vm 444 config/schemas.xml $(BASE)/
# 	@$(WGET) $(DOCBOOK)/docbook.rnc  -O $(BASE)/docbook.rnc
# 	@$(WGET) $(DOCBOOK)/dbnotnx.rnc  -O $(BASE)/dbnotnx.rnc
# 	@$(WGET) $(DOCBOOK)/dbpoolx.rnc  -O $(BASE)/dbpoolx.rnc
# 	@$(WGET) $(DOCBOOK)/htmltblx.rnc -O $(BASE)/htmltblx.rnc
# 	@$(WGET) $(DOCBOOK)/calstblx.rnc -O $(BASE)/calstblx.rnc
#  	@$(WGET) $(DOCBOOK)/dbhierx.rnc  -O $(BASE)/dbhierx.rnc

	install -vd $(BASE)/template
	install -vm 444 template/* $(BASE)/template/
