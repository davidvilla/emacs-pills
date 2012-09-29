; -*- tab-width:4; fill-column:90; mode:lisp -*-

;| Activates and binds RefTeX minor mode.
;| Provides a live checker for flymake (disabled by default). To enable it::
;|
;|   M-x flymake-mode

(setq TeX-auto-save t)

(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.
(setq TeX-auto-local "")

(setq-default TeX-master "main")

; Activate and connect RefTeX
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)

(defun flymake-get-tex-args (file-name)
  (list "/usr/share/arco/flymake-latex-checker" (list file-name)))


; http://wikemacs.org/wiki/AUCTeX
;; (setq TeX-view-program-selection
;;       '((output-dvi "DVI Viewer")
;;         (output-pdf "PDF Viewer")
;;         (output-html "HTML Viewer")))
