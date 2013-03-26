; http://nschum.de/src/emacs/compile-bookmarks/

;| store and reuse compile commands
;|
;| C-c F5   Run all tests


(require 'compile-bookmarks)
(compile-bookmarks-mode 1)

(define-key compile-bookmarks-mode-map (kbd "C-c <f5>")
  compile-bm-shortcut-map)
