SOURCES=$(wildcard *.cfg.el)

all:  ../README.rst
	echo $(shell pwd)
	ls *.cfg.el | awk '{print "(byte-compile-file \"" $$1 "\")";}' > bytecompile.el
	/usr/bin/emacs -L ../modules -batch -l bytecompile.el -kill

%.html: %.rst $(SOURCES) gen-doc.py
	rst2html --generator --date --stylesheet ./style.css $< $@

%.1: $.rst $(SOURCES) gen-doc.py
	rst2man $< $@

../README.rst: $(SOURCES) Makefile header.rst gen-doc.py template.el
	./gen-doc.py $@

template.el: $(SOURCES) Makefile
	@echo \(load-file \"/usr/share/emacs-pills/init.el\"\) > $@
	@for f in *.cfg.el partial/*.cfg.el; do \
	   echo "(load \"$$(basename $$f .el)\")" >> $@; \
	done
	@for f in python/*.cfg.el; do \
	   echo "(load \"$$(basename $$f .el)\")  ;requires emacs-pills-python" >> $@; \
	done

clean:
	$(RM) *.html *.elc *.1
	$(RM) $(shell find . -name "*.elc")
	$(RM) bytecompile.el
