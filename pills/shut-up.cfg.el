; -*- tab-width:4; fill-column:90; mode:lisp -*-

;| Make emacs quieter

(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))
