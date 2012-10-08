;| Activate rst-mode for *.rst files

; ;; ReST
(require 'rst)
;(setq auto-mode-alist
;      (append '(("\\.rst$" . rst-mode)
;		("\\.rest$" . rst-mode)) auto-mode-alist))

(setq auto-mode-alist (cons '("\\.rst$" . rst-mode) auto-mode-alist))
