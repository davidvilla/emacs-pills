===========================
Modular Emacs Configuration
===========================

It is a set of configuration "fragments" that you may use independently.

To use one of these in your Emacs you must install the ``arco-emacs`` debian
package adding next line to your ``/etc/apt/sources.list``::

  deb http://babel.esi.uclm.es/arco sid main

And run::

  $ sudo apt-get install arco-emacs
  $ sudo apt-get install arco-emacs-python

Then, write down something like that in your ``~/.emacs``::

  (add-to-list 'load-path "/usr/share/arco/emacs")
  (load "minimal.cfg")
  (load "tabbar.cfg")
  (load "maximize.cfg")


.. Local Variables:
..  coding: utf-8
..  mode: flyspell
..  ispell-local-dictionary: "american"
.. End:
