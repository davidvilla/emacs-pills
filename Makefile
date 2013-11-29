#!/usr/bin/make -f
# -*- coding:utf-8 -*-

DESTDIR?=~

BASE=$(DESTDIR)/usr/share/emacs-pills
OLDBASE=$(DESTDIR)/usr/share/arco/emacs
YASNIPPET=$(DESTDIR)/usr/share/emacs/site-lisp/yasnippet/snippets
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
	install -vd $(YASNIPPET)/text-mode
	install -v -m 444 yasnippet/text-mode/* $(YASNIPPET)/text-mode/
	install -vd $(YASNIPPET)/fundamental-mode
	install -v -m 444 yasnippet/fundamental-mode/.yas-parents $(YASNIPPET)/fundamental-mode/
	install -vd $(YASNIPPET)/python-mode
	install -v -m 444 yasnippet/python-mode/* $(YASNIPPET)/python-mode/
	install -vd $(YASNIPPET)/ruby-mode
	install -v -m 444 yasnippet/ruby-mode/* $(YASNIPPET)/ruby-mode/
	install -vd $(YASNIPPET)/latex-mode
	install -v -m 444 yasnippet/latex-mode/* $(YASNIPPET)/latex-mode/
#	install -vd $(YASNIPPET)/xml-mode
#	install -v -m 444 yasnippet/xml-mode/* $(YASNIPPET)/xml-mode/
	install -vd $(YASNIPPET)/makefile-mode
	install -v -m 444 yasnippet/makefile-mode/* $(YASNIPPET)/makefile-mode/

	install -vd $(BASE)
	install -vm 444 config/*.cfg.elc $(BASE)/
	install -vm 444 config/partial/*.cfg.el $(BASE)/
	install -vm 444 config/python/*.cfg.el $(BASE)/

	install -vm 444 config/template.el $(BASE)/
	install -vm 444 config/init.el $(BASE)/

	install -vm 444 modules/*.el $(BASE)/
	install -vd $(BASE)/23
	install -vm 444 modules/23/*.el $(BASE)/23/

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
