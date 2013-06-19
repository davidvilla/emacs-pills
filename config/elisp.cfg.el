;| elisp utitlity functions
;|
;| - eval-and-replace
;|
;| (new in version 0.20130619)


; http://irreal.org/blog/?p=297
(defun eval-and-replace (value)
  "Evaluate the sexp at point and replace it with its value"
  (interactive (list (eval-last-sexp nil)))
  (kill-sexp -1)
  (insert (format "%S" value)))
