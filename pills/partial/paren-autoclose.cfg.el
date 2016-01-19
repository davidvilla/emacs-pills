; -*- mode:lisp -*-

;| Automatic close for parentheses (and other pair stuff) when you write the
;| opening one. Now using "autopair"
;|
;| (new in version 0.20131129)

(load "package.cfg")

(pills-depend-install 'autopair)
(autopair-global-mode t)
(setq autopair-blink nil)


;; ;; Auto-insert clossing pair
;; (defvar skeleton-pair)
;; (setq skeleton-pair t)
;; (global-set-key "[" 'skeleton-pair-insert-maybe)
;; (global-set-key "(" 'skeleton-pair-insert-maybe)
;; (global-set-key "{" 'skeleton-pair-insert-maybe)
;; (global-set-key "'" 'skeleton-pair-insert-maybe)
;; (global-set-key "\"" 'skeleton-pair-insert-maybe)
;; (global-set-key "«" 'skeleton-pair-insert-maybe)
