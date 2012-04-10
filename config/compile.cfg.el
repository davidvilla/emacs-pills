; -*- mode:lisp -*-

;| Convenience configuration for ``compile`` command.
;| - auto-save file instead of asking


(setq compilation-scroll-output t)

; automatically save buffer when ask for compilation
; http://stackoverflow.com/questions/2062492/save-and-compile-automatically
(setq compilation-ask-about-save nil)
