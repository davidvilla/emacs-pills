; http://stackoverflow.com/questions/10092322/how-to-automatically-install-emacs-packages-by-specifying-a-list-of-package-name

(when (= emacs-major-version 23)
  (add-to-list 'load-path "/usr/share/emacs-pills/23/")
  )

(require 'package)
(package-initialize)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(when (not package-archive-contents)
  (package-refresh-contents))

(defun pills-depend-install (package)
  (when (not (package-installed-p package))
    (package-install package)
    )
  )
