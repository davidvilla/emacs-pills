; -*- tab-width:4; fill-column:90; mode:lisp -*-

;| Activates and binds RefTeX minor mode.
;| Provides a live checker for flymake (disabled by default). To enable it::
;|
;|   M-x flymake-mode


(defvar TeX-auto-save)
(defvar TeX-auto-local)
(defvar TeX-parse-self)
(defvar reftex-plug-into-AUCTeX)

(eval-after-load 'latex (progn
  (setq TeX-auto-save t) ; Enable parse on save.
  (setq TeX-auto-local "/tmp/auctex-auto/") ; where to save parsing
  (setq TeX-parse-self t) ; Enable parse on load.
  (setq-default TeX-master "main")
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)  ; Activate and connect RefTeX
  (setq reftex-plug-into-AUCTeX t)
 ;(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook 'flyspell-mode)
  (add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
  (setq TeX-view-program-list '(("Evince" "evince --page-index=%(outpage) %o")))
  (setq TeX-view-program-selection '((output-pdf "Evince")))
  (setq-default TeX-PDF-mode t)
))

(defun flymake-get-tex-args (file-name)
  (list "/usr/share/emacs-pills/flymake-latex-checker" (list file-name)))


; http://wikemacs.org/wiki/AUCTeX
;; (setq TeX-view-program-selection
;;       '((output-dvi "DVI Viewer")
;;         (output-pdf "PDF Viewer")
;;         (output-html "HTML Viewer")))



(load "auctex.el" nil t t)


; http://superuser.com/questions/253525/emacs-auctex-how-do-i-open-the-pdf-in-evince-at-the-current-cursor-position/256978#256978
; http://milkbox.net/note/single-file-master-emacs-configuration/

;; (setq TeX-source-correlate-method 'synctex)
;; (setq TeX-source-correlate-start-server t)


;; http://milkbox.net/note/single-file-master-emacs-configuration/
;; (after 'latex
;;   (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
;;   (add-hook 'LaTeX-mode-hook 'variable-pitch-mode)
;;   (add-hook 'LaTeX-mode-hook 'TeX-fold-mode)

;;   (setq TeX-save-query nil)
;;   (setq TeX-item-indent 0)
;;   (setq TeX-newline-function 'reindent-then-newline-and-indent)

;;   (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;;   (setq reftex-plug-into-AUCTeX t)
;;   (define-key TeX-mode-map (kbd "C-M-h") 'mark-paragraph)
;;   (define-key TeX-mode-map (kbd "C-c C-m") 'TeX-command-master)
;;   (define-key TeX-mode-map (kbd "C-c C-c") 'TeX-compile))
