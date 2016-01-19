; -*- mode:lisp -*-

;| Create intermediate directories when saving a new file in a non existing path.

; http://stackoverflow.com/questions/6830671/how-to-make-emacs-create-intermediate-dirs-when-saving-a-file

;; (add-hook 'before-save-hook
;;   (lambda ()
;;     (when buffer-file-name
;;       (let ((dir (file-name-directory buffer-file-name)))
;;         (when (and (not (file-exists-p dir))
;;                    (y-or-n-p (format "Directory %s does not exist. Create it? " dir)))
;;           (make-directory dir t))))))


; Automatically create missing parent directories when you 'open' a new file
; http://atomized.org/2008/12/emacs-create-directory-before-saving/
(add-hook 'before-save-hook
  '(lambda ()
     (or (file-exists-p (file-name-directory buffer-file-name))
	 (make-directory (file-name-directory buffer-file-name) t))))
