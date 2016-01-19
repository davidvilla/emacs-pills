; -*- tab-width:4; fill-column:90; mode:lisp -*-

;| Customization for the multiple-cursor mode
;|
;| Keystrokes:
;|
;| - C-S-c C-S-c: add cursors for region
;| - C->: add cursor for the next occurence
;| - C->: add cursor for the previous occurence
;| - C-c C-<: add cursors to all ocurrences
;|
;| See: https://github.com/magnars/multiple-cursors.el
;|
;| (new in version 0.20131129)

(load "package.cfg")

(pills-depend-install 'multiple-cursors)

(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
