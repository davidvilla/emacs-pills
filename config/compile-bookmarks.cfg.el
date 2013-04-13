;| store and reuse compile commands
;|
;| See http://nschum.de/src/emacs/compile-bookmarks/
;|
;| (new in version 0.20130327)

(add-to-list 'load-path "/usr/share/emacs-pills")
(require 'compile-bookmarks)

(compile-bookmarks-mode 1)

(define-key compile-bookmarks-mode-map (kbd "C-c <f5>")
  compile-bm-shortcut-map)
