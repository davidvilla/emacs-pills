; -*- tab-width:4; fill-column:90; mode:lisp -*-

;| Minor mode to gain screen space when use a projector
;|
;| - Hides toolbar, menubar and scrollbar
;| - Activates hl-line and linum modes
;|
;| (new in version FIXME)

(define-minor-mode
  projector-mode
  "projector-aware minor mode"
  nil
  nil
  nil
  (if projector-mode
    (progn
	  (tool-bar-mode -1)
	  (menu-bar-mode -1)
	  (scroll-bar-mode -1)
	  (hl-line-mode 1)
	  (linum-mode 1)
	)
    (progn
	  (tool-bar-mode 1)
	  (menu-bar-mode 1)
	  (scroll-bar-mode 1)
	  (hl-line-mode -1)
	  (linum-mode -1)
	)
  )
)
