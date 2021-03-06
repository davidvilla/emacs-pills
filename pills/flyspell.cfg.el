; -*- tab-width:4; fill-column:90; mode:lisp -*-

;| Better config and colors for the flyspell minor mode.
;| It is automatically loadad for LaTeX, resT, conf and sgml modes.
;|
;| To load on other modes add something like next to your config::
;|
;|   (add-hook 'foo-mode-hook 'turn-on-flyspell)

(custom-set-variables
 '(flyspell-highlight-flag t)
 '(flyspell-highlight-properties t)
 '(flyspell-issue-message-flag nil)
 )

(custom-set-faces
 '(flyspell-duplicate ((t (:background "#ffeecc" :foreground "gray10"))))
 '(flyspell-incorrect ((default (:background "#ffd0d0" :foreground "gray10")) (nil nil)))
 )

(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(add-hook 'LaTeX-mode-hook 'turn-on-flyspell)
(add-hook 'rst-mode-hook 'turn-on-flyspell)
;(add-hook 'conf-mode-hook 'turn-on-flyspell)
(add-hook 'sgml-mode-hook 'turn-on-flyspell)
