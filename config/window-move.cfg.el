; -*- tab-width:4; fill-column:90; mode:lisp -*-

;| Move among windows with keyboard
;|
;| Keystrokes:
;|
;| - Control-Super-left:  Move to left window
;| - Control-Super-right: Move to right window
;| - Control-Super-up:    Move to upper window
;| - Control-Super-down:  Move to downer window

;(windmove-default-keybindings 'meta)

(global-set-key [C-s-left] 'windmove-left)
(global-set-key [C-s-right] 'windmove-right)
(global-set-key [C-s-up] 'windmove-up)
(global-set-key [C-s-down] 'windmove-down)
