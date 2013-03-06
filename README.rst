===========================
Modular Emacs Configuration
===========================

It is a set of configuration "fragments" that you may use independently.

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


.. Local Variables:
..  coding: utf-8
..  mode: flyspell
..  ispell-local-dictionary: "american"
.. End:

`auto-complete.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/auto-complete.cfg.el>`_
======================================================================================================

Minimal configuration for auto-complete mode. This minor mode is not
activated by default. You must run::

  M-x auto-complete-mode

`auto-insert.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/auto-insert.cfg.el>`_
==================================================================================================

It contains a set of templates that are automatically inserted when you
create empty files. It includes default headers for Python, bash, LaTeX and
others.

`compile.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/compile.cfg.el>`_
==========================================================================================

Convenience configuration for ``compile`` command.
- auto-save file instead of asking

`docbook.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/docbook.cfg.el>`_
==========================================================================================

nxml-mode configuration for DocBook 4.5.

`flymake.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/flymake.cfg.el>`_
==========================================================================================

custom config and faces for flymake error highlight.

`flyspell.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/flyspell.cfg.el>`_
============================================================================================

Better config and colors for the flyspell minor mode.
It is automatically loadad for LaTeX, resT, conf and sgml modes.

To load on other modes add something like next to your config::

  (add-hook 'foo-mode-hook 'turn-on-flyspell)

`global-zoom.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/global-zoom.cfg.el>`_
==================================================================================================

It provides zoom on emacs in a similar way to web browsers or text processors suites.

Keystrokes:

- C-<plus> or C-mousewheel-up: increases font size.
- C-<minus> or C-mousewheel-down: decreases font size.
- C-0 reverts font size to default.

In contrast to zoom.cfg this version persists across multiple areas
of the document with specific minor modes (e.g. noweb documents)

`highlight-changes.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/highlight-changes.cfg.el>`_
==============================================================================================================

Activate ``highlight-changes-mode`` and set better colors. It highlights all
modifications since file open.

Keystrokes:

F6: shows/hide hightlight (deactivated by default).

`hl.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/hl.cfg.el>`_
================================================================================

Highlight the current line.

- Deactivate temporally::

    M-x global-hl-line-mode

- Deactivate per major-mode::

    (add-hook 'ruby-mode-hook 'local-hl-line-mode-off)

`latex.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/latex.cfg.el>`_
======================================================================================

Activates and binds RefTeX minor mode.
Provides a live checker for flymake (disabled by default). To enable it::

  M-x flymake-mode

`maximize.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/maximize.cfg.el>`_
============================================================================================

Maximize the Emacs X window.

Keystrokes:

- F11: toogles fullscreen.
- C-F11: toogles vertical maximization.

`minimal.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/minimal.cfg.el>`_
==========================================================================================

Basic customization useful for most of users. It does not provide new keystrokes or
commands.

`move-line-or-region.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/move-line-or-region.cfg.el>`_
==================================================================================================================

Move line (or current selected area) up and down.

Keystrokes:

- M-up:   move text up
- M-down: move text down

`paren-autoclose.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/paren-autoclose.cfg.el>`_
==========================================================================================================

Automatic close for parentheses (and other pair stuff) when you write the
opening one.

`psgml.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/psgml.cfg.el>`_
======================================================================================

- Better faces and highlight for sgml-mode
- Automatic DTD detection and loading.

`python.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/python.cfg.el>`_
========================================================================================

flymake configuration for python-mode (enabled by default).
Set pyflakes as Python syntax checker. Run with C-c C-v

`slice.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/slice.cfg.el>`_
======================================================================================

Syntax highlight (with c++-mode) for .ice files

`speedbar.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/speedbar.cfg.el>`_
============================================================================================

It provides F9 to show/hide the speedbar, and set position to right.

`strip.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/strip.cfg.el>`_
======================================================================================

On save, automatically:

- remove trailing spaces at end of lines,
- assure an empty line at end of buffer

Keystrokes: None

`tabbar.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/tabbar.cfg.el>`_
========================================================================================

A very good customization for tabbar-mode.

- Better faces for tabs.
- Separate buffers in three independent groups: user files, dired and messages.

Keystrokes:

- M-<n> for the first 10 tabs
- C-S-left and C-S-right to change among buffers in the same group.
- C-S-up and C-S-down to change among groups.

`toggle-split.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/toggle-split.cfg.el>`_
====================================================================================================

Keystrokes:

- C-x 4: Changes among vertical and horizontal two-window layouts.

`uniquify.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/uniquify.cfg.el>`_
============================================================================================

uniquify customization to use directory instead of a number to differentiate
buffers with the same filename.

Keystrokes: None

`window-move.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/window-move.cfg.el>`_
==================================================================================================

Move among windows with keyboard

Keystrokes:

- Shift-Meta-left:  Move to left window
- Shift-Meta-right: Move to right window
- Shift-Meta-up:    Move to upper window
- Shift-Meta-down:  Move to downer window

`zoom.cfg <https://bitbucket.org/arco_group/emacs-pills/src/tip/config/zoom.cfg.el>`_
====================================================================================

It provides zoom on emacs in a similar way to web browsers or text processors suites.

Keystrokes:

- C-<plus> or C-mousewheel-up: increases font size.
- C-<minus> or C-mousewheel-down: decreases font size.
- C-0 reverts font size to default.
