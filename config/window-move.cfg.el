; -*- tab-width:4; fill-column:90; mode:lisp -*-

;| Move among windows with keyboard
;|
;| Keystrokes:
;|
;| - Shift-Meta-left:  Move to left window
;| - Shift-Meta-right: Move to right window
;| - Shift-Meta-up:    Move to upper window
;| - Shift-Meta-down:  Move to downer window

;(windmove-default-keybindings 'meta)

(global-set-key [S-M-left] 'windmove-left)
(global-set-key [S-M-right] 'windmove-right)
(global-set-key [S-M-up] 'windmove-up)
(global-set-key [S-M-down] 'windmove-down)
