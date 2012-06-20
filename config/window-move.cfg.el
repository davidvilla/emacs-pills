; -*- tab-width:4; fill-column:90; mode:lisp -*-

;| Move among windows with keyboard
;|
;| Keystrokes:
;|
;| - Super-left:  Move to left window
;| - Super-right: Move to right window
;| - Super-up:    Move to upper window
;| - Super-down:  Move to downer window

;(windmove-default-keybindings 'meta)

(global-set-key [s-left] 'windmove-left)
(global-set-key [s-right] 'windmove-right)
(global-set-key [s-up] 'windmove-up)
(global-set-key [s-down] 'windmove-down)
