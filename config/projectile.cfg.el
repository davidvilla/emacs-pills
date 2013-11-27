; -*- mode:lisp -*-
; author: David.Villa@uclm.es

;| Projectile mode config and customizations
;|
;| Reference: https://github.com/bbatsov/projectile

(load "package.cfg")

(pills-depend-install 'pkg-info)
(pills-depend-install 'dash)
(pills-depend-install 'projectile)

(projectile-global-mode)

(load "tabbar.cfg")

(setq tabbar-buffer-groups-function
      (lambda ()
	(let ((dir (expand-file-name default-directory)))
	  (cond
	   ((eq major-mode 'compilation-mode) (list "Compilation"))
	   ((string-equal "*" (substring (buffer-name) 0 1)) (list "Emacs"))
	   ((eq major-mode 'dired-mode) (list "Dired"))
	       ((condition-case err (projectile-project-root)
		  (error nil)) (list (projectile-project-name)))
	   ((string-match-p "/.emacs.d/" dir) (list ".emacs.d"))
	   (t (list dir)))
	  )))
