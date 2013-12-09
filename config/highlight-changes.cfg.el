; -*- tab-width:4; fill-column:90; mode:lisp -*-

; http://emacs-fu.blogspot.com/2009/05/tracking-changes.html

;| Activate ``highlight-changes`` minor mode and set better colors. It highlights all
;| modifications since file was open.
;|
;| Keystrokes:
;|
;| - F6: shows/hide hightlight (deactivated by default).

(add-hook 'after-make-frame-functions
  (lambda (frame)
	(select-frame frame)
	(when window-system
	  (global-highlight-changes-mode t)

	  (defvar highlight-changes-visibility-initial-state)
	  (setq highlight-changes-visibility-initial-state nil)  ; initially hide
	  (global-set-key (kbd "<f6>") 'highlight-changes-visible-mode)

	  (set-face-foreground 'highlight-changes "#0000ff")
	  (set-face-background 'highlight-changes "#e0e0ff")
	  (set-face-foreground 'highlight-changes-delete nil)
	  (set-face-background 'highlight-changes-delete "#ffcccc")
	  )
	)
  )
