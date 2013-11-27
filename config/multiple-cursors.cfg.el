; -*- tab-width:4; fill-column:90; mode:lisp -*-

;| keybindings for the multiple-cursor mode
;|
;| FIXME: specify keybindings
;|
;| https://github.com/magnars/multiple-cursors.el

(load "package.cfg")

(pills-depend-install 'multiple-cursors)

(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
