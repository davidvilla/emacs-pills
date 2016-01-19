;;; flymake.cfg.el ---

;| custom config and faces for flymake error highlight.

(defvar flymake-fringe-indicator-position)
(setq flymake-fringe-indicator-position nil)

(custom-set-faces
 '(flymake-errline ((((class color) (background light))
     (:background "#ffd0d0" :foreground "gray10"))))
 '(flymake-warnline ((((class color) (background light))
     (:background "#ffeecc" :foreground "gray10"))))
)

(defvar flymake-no-changes-timeout)
(setq flymake-no-changes-timeout 2)
