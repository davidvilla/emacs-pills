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

Then, write down something like that in your ``~/.emacs`` and comment
out undesired pills::

  (add-to-list 'load-path "/usr/share/arco/emacs")
  (load "auto-complete.cfg")
  (load "auto-create-dirs.cfg")
  (load "auto-insert.cfg")
  (load "compile-bookmarks.cfg")
  (load "compile.cfg")
  (load "docbook.cfg")
  (load "epy-nose.cfg")
  (load "flymake.cfg")
  (load "flyspell.cfg")
  (load "global-zoom.cfg")
  (load "highlight-changes.cfg")
  (load "hl.cfg")
  (load "latex.cfg")
  (load "maximize.cfg")
  (load "minimal.cfg")
  (load "move-line-or-region.cfg")
  (load "paren-autoclose.cfg")
  (load "psgml.cfg")
  (load "python.cfg")
  (load "rst.cfg")
  (load "slice.cfg")
  (load "speedbar.cfg")
  (load "strip.cfg")
  (load "tabbar.cfg")
  (load "toggle-split.cfg")
  (load "uniquify.cfg")
  (load "window-move.cfg")
  (load "zoom.cfg")

`auto-complete.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/auto-complete.cfg.el>`_
=======================================================================================================

Minimal configuration for auto-complete mode. This minor mode is not
activated by default. You must run::

  M-x auto-complete-mode

`auto-create-dirs.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/auto-create-dirs.cfg.el>`_
=============================================================================================================

Create intermediate directories when saving a new file

`auto-insert.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/auto-insert.cfg.el>`_
===================================================================================================

It contains a set of templates that are automatically inserted when you
create empty files. It includes default headers for Python, bash, LaTeX and
others.

`compile-bookmarks.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/compile-bookmarks.cfg.el>`_
===============================================================================================================

store and reuse compile commands

See http://nschum.de/src/emacs/compile-bookmarks/

(new in version 0.20130327)

`compile.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/compile.cfg.el>`_
===========================================================================================

Convenience configuration for ``compile`` command. See the `compile-screencast`_.

.. _compile-screencast: http://youtu.be/34B3mkPj01s

- auto-save file before compilation, instead of asking.
- modeline background color represents compilation process:

  - blue: compilation in progress
  - green:  compilation finished successfully
  - orange: compilation finished with warnnings
  - red: compilation finished with errors

Keystrokes:

- F5 recompile
- C-F5 opens compilation buffer

(new in version 0.20130327)

`docbook.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/docbook.cfg.el>`_
===========================================================================================

nxml-mode configuration for DocBook 4.5.

`epy-nose.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/epy-nose.cfg.el>`_
=============================================================================================

nose python test runner bindings:

- C-ca   Run all tests
- C-cM   Run module tests
- C-c.   Run current test
- C-cx   Stop nose
- C-cpa  Run all tests (run pdb on fail)
- C-cpm  Run module tests (run pdb on fail)
- C-cp.  Run current test (run pdb on fail)

(new in version 0.20130327)

`flymake.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/flymake.cfg.el>`_
===========================================================================================

custom config and faces for flymake error highlight.

`flyspell.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/flyspell.cfg.el>`_
=============================================================================================

Better config and colors for the flyspell minor mode.
It is automatically loadad for LaTeX, resT, conf and sgml modes.

To load on other modes add something like next to your config::

  (add-hook 'foo-mode-hook 'turn-on-flyspell)

`global-zoom.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/global-zoom.cfg.el>`_
===================================================================================================

It provides zoom on emacs in a similar way to web browsers or text processors suites.

Keystrokes:

- C-<plus> or C-mousewheel-up: increases font size.
- C-<minus> or C-mousewheel-down: decreases font size.
- C-0 reverts font size to default.

In contrast to zoom.cfg this version persists across multiple areas
of the document with specific minor modes (e.g. noweb documents)

`highlight-changes.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/highlight-changes.cfg.el>`_
===============================================================================================================

Activate ``highlight-changes-mode`` and set better colors. It highlights all
modifications since file open.

Keystrokes:

F6: shows/hide hightlight (deactivated by default).

`hl.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/hl.cfg.el>`_
=================================================================================

Highlight the current line.

- Deactivate temporally::

    M-x global-hl-line-mode

- Deactivate per major-mode::

    (add-hook 'ruby-mode-hook 'local-hl-line-mode-off)

`latex.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/latex.cfg.el>`_
=======================================================================================

Activates and binds RefTeX minor mode.
Provides a live checker for flymake (disabled by default). To enable it::

  M-x flymake-mode

`maximize.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/maximize.cfg.el>`_
=============================================================================================

Maximize the Emacs X window.

Keystrokes:

- F11: toogles fullscreen.
- C-F11: toogles vertical maximization.

`minimal.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/minimal.cfg.el>`_
===========================================================================================

Basic customization useful for most of users. It does not provide new keystrokes or
commands.

`move-line-or-region.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/move-line-or-region.cfg.el>`_
===================================================================================================================

Move line (or current selected area) up and down.

Keystrokes:

- M-up:   move text up
- M-down: move text down

`paren-autoclose.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/paren-autoclose.cfg.el>`_
===========================================================================================================

Automatic close for parentheses (and other pair stuff) when you write the
opening one.

`psgml.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/psgml.cfg.el>`_
=======================================================================================

- Better faces and highlight for sgml-mode
- Automatic DTD detection and loading.

`python.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/python.cfg.el>`_
=========================================================================================

flymake configuration for python-mode (enabled by default).
Set pyflakes as Python syntax checker. Run with C-c C-v

`rst.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/rst.cfg.el>`_
===================================================================================

Activate rst-mode for *.rst files

`slice.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/slice.cfg.el>`_
=======================================================================================

Syntax highlight (with c++-mode) for .ice files

`speedbar.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/speedbar.cfg.el>`_
=============================================================================================

It provides F9 to show/hide the speedbar, and set position to right.

`strip.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/strip.cfg.el>`_
=======================================================================================

On save, automatically:

- remove trailing spaces at end of lines,
- assure an empty line at end of buffer

Keystrokes: None

`tabbar.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/tabbar.cfg.el>`_
=========================================================================================

A very good customization for tabbar-mode.

- Better faces for tabs.
- Separate buffers in three independent groups: user files, dired and messages.

.. image:: http://crysol.org/files/emacs-tabbar.png

Keystrokes:

- M-<n> for the first 10 tabs
- C-S-left and C-S-right to change among buffers in the same group.
- C-S-up and C-S-down to change among groups.

`toggle-split.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/toggle-split.cfg.el>`_
=====================================================================================================

Keystrokes:

- C-x 4: Changes among vertical and horizontal two-window layouts.

`uniquify.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/uniquify.cfg.el>`_
=============================================================================================

uniquify customization to use directory instead of a number to differentiate
buffers with the same filename.

Keystrokes: None

`window-move.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/window-move.cfg.el>`_
===================================================================================================

Move among windows with keyboard

Keystrokes:

- Control-Super-left:  Move to left window
- Control-Super-right: Move to right window
- Control-Super-up:    Move to upper window
- Control-Super-down:  Move to downer window

`zoom.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/zoom.cfg.el>`_
=====================================================================================

It provides zoom on emacs in a similar way to web browsers or text processors suites.

Keystrokes:

- C-<plus> or C-mousewheel-up: increases font size.
- C-<minus> or C-mousewheel-down: decreases font size.
- C-0 reverts font size to default.

