SOURCES=$(wildcard *.cfg.el)

all: ../README.rst

%.html: %.rst $(SOURCES) gen-doc.py
	rst2html --generator --date --stylesheet ./style.css $< $@

%.1: $.rst $(SOURCES) gen-doc.py
	rst2man $< $@

../README.rst: $(SOURCES) Makefile header.rst gen-doc.py
	./gen-doc.py $@

clean:
	$(RM) *.html *.1 modular-emacs-conf.rst
