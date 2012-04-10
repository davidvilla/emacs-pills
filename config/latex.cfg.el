; -*- tab-width:4; fill-column:90; mode:lisp -*-

;| Activates and binds RefTeX minor mode.
;| Provides a live checker for flymake (disabled by default). To enable it::
;|
;|   M-x flymake-mode

; Activate and connect RefTeX
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;(setq-default TeX-master nil)  ; Query for master file.
;(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(defun flymake-get-tex-args (file-name)
  (list "/usr/share/arco/flymake-latex-checker" (list file-name)))
