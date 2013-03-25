===========================
Modular Emacs Configuration
===========================

It is a set of configuration config "fragments" (pills) that you may use independently,
but it is warrantied that all of them work well together.

To use one of these in your Emacs you must install the ``emacs-pills`` debian
package adding next line to your ``/etc/apt/sources.list``::

  deb http://babel.esi.uclm.es/arco sid main

And run::

  $ sudo apt-get install emacs-pills
  $ sudo apt-get install emacs-pills-python

Then, write down something like that in your ``~/.emacs``::

  (add-to-list 'load-path "/usr/share/arco/emacs")
  (load "minimal.cfg")
  (load "tabbar.cfg")
  (load "maximize.cfg")

adding what you want...


.. Local Variables:
..  coding: utf-8
..  mode: flyspell
..  ispell-local-dictionary: "american"
.. End:
