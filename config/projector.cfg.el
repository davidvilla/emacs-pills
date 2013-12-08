(define-minor-mode
  projector-mode
  "some doc"
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
