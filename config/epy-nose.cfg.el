; from emacs-for-python

;| nose python test runner bindings:
;|
;| - C-ca   Run all tests
;| - C-cM   Run module tests
;| - C-c.   Run current test
;| - C-cx   Stop nose
;| - C-cpa  Run all tests (run pdb on fail)
;| - C-cpm  Run module tests (run pdb on fail)
;| - C-cp.  Run current test (run pdb on fail)
;|
;| (new in version 0.20130327)


(require 'nose)

;; Nose bindings
(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key "\C-ca" 'nosetests-all)
            (local-set-key "\C-cM" 'nosetests-module)  ;; C-c m conflicts w/ pylint
            (local-set-key "\C-c." 'nosetests-one)
            (local-set-key "\C-cx" 'nosetests-stop)
            (local-set-key "\C-cpa" 'nosetests-pdb-all)
            (local-set-key "\C-cpm" 'nosetests-pdb-module)
            (local-set-key "\C-cp." 'nosetests-pdb-one))
          )


(provide 'epy-nose)
