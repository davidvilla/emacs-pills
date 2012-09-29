SOURCES=$(wildcard *.cfg.el)

all: ../README.rst ../template.el

%.html: %.rst $(SOURCES) gen-doc.py
	rst2html --generator --date --stylesheet ./style.css $< $@

%.1: $.rst $(SOURCES) gen-doc.py
	rst2man $< $@

../README.rst: $(SOURCES) Makefile header.rst gen-doc.py
	./gen-doc.py $@

../template.el: $(SOURCES)
	@echo \(add-to-list \'load-path \"/usr/share/arco/emacs\"\) > $@
	@for f in *.cfg.el; do \
	   echo \(load \"$$(basename $$f .el)\"\) >> $@; \
	done

clean:
	$(RM) *.html *.elc *.1 modular-emacs-conf.rst
