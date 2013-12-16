===========================
Modular Emacs Configuration
===========================

It is a set of configuration "fragments" (pills) that you may use independently,
but it is warrantied that all of them work well together.

To use one of these in your Emacs you must install the ``emacs-pills`` debian
package adding next line to your ``/etc/apt/sources.list``::

  deb http://babel.esi.uclm.es/arco sid main

And run::

  $ sudo apt-get install emacs-pills
  $ sudo apt-get install emacs-pills-python

Then, write down something like that in your ``~/.emacs`` and comment
out undesired pills::
