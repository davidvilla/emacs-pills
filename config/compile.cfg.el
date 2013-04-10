; -*- mode:lisp -*-

;| Convenience configuration for ``compile`` command.
;|
;| - auto-save file before compilation, instead of asking.
;| - modeline background color represents compilation process:
;|
;|   - blue: compilation in progress
;|   - green:  compilation finished successfully
;|   - orange: compilation finished with warnnings
;|   - red: compilation finished with errors
;|
;| Keystrokes:
;|
;| - F5 recompile
;| - C-F5 opens compilation buffer
;|
;| (new in version 0.20130327)

; References:
; - http://vwood.github.com/emacs-compile-on-save.html
; - http://comments.gmane.org/gmane.emacs.devel/156498

(setq compilation-scroll-output 'first-error)

; automatically save buffer when ask for compilation
; http://stackoverflow.com/questions/2062492/save-and-compile-automatically
(setq compilation-ask-about-save nil)

(setq modeline-timer nil)

; http://lazywithclass.posterous.com/emacs-functions-to-ease-tdd
(defun modeline-set-color (color)
  "Colors the modeline"
  (interactive)
  (set-face-background 'modeline color))

(defun modeline-cancel-timer ()
  (let ((m modeline-timer))
	(when m
	  (cancel-timer m)
	  (setq modeline-timer nil))))

(defun modeline-delayed-clean ()
  (modeline-cancel-timer)
  (setq modeline-timer
		(run-at-time "2 sec" nil 'modeline-set-color nil)))

; (defun no-color-modeline()
;   "No color for the modeline"
;   (interactive)
;   (set-face-background 'modeline nil))


; from http://emacswiki.org/emacs/CompileCommand (Xu Yuan)
; (defun notify-compilation-result(buffer msg)
;   "Notify that the compilation is finished,
; close the *compilation* buffer if the compilation is successful,
; and set the focus back to Emacs frame"
;   (if (string-match "^finished" msg)
;     (progn
;      (delete-windows-on buffer)
;      (color-modeline 0))
;     (color-modeline 1))
;   (setq current-frame (car (car (cdr (current-frame-configuration)))))
;   (select-frame-set-input-focus current-frame)
;   )
;
; (add-to-list 'compilation-finish-functions 'notify-compilation-result)


(defun open-compilation-buffer()
    (interactive)
    (display-buffer "*compilation*")
	(modeline-delayed-clean)
	)


(defun compilation-exit-hook (status code msg)
  ;; If M-x compile exists with a 0
  (if (and (eq status 'exit) (zerop code))
    (progn
      (if (string-match "warning:" (buffer-string))
		  (modeline-set-color "orange")
		  (progn (modeline-set-color "YellowGreen")
				 (modeline-delayed-clean)))
;				 (run-at-time "2 sec" nil 'modeline-set-color nil)))
      (other-buffer (get-buffer "*compilation*"))
;      (delete-windows-on (get-buffer "*compilation*"))
      )
    (progn
	  (modeline-set-color "OrangeRed")
	  (open-compilation-buffer)))

  (setq current-frame (car (car (cdr (current-frame-configuration)))))
  (select-frame-set-input-focus current-frame)
  ;; Always return the anticipated result of compilation-exit-message-function
  (cons msg code))
;
(setq compilation-exit-message-function 'compilation-exit-hook)


; ;; Bury the compilation buffer when compilation is finished and successful.
; (add-to-list 'compilation-finish-functions
;   (lambda (buffer msg)
;     (when (bury-buffer buffer)
;       (replace-buffer-in-windows buffer))))

;http://vwood.github.com/emacs-compile-on-save.html
;; Prevent compilation buffer from showing up

(defun hide-compilation-buffer
  (lambda()
	(defadvice compile (around compile/save-window-excursion first () activate)
	  (save-window-excursion ad-do-it))
	))

; (hide-compilation-buffer)

(defadvice recompile (around compile/save-window-excursion first () activate)
   (save-window-excursion ad-do-it))

; (defun recompile-after-save()
;   (message "Compiling after saving...")
; ;  (interactive)
; ;  (ignore-errors (kill-compilation))
;   (recompile)
;   )
; ;
; ; (add-to-list 'after-save-hook 'recompile-after-save)


; (global-set-key (kbd "<f5>")
;   (lambda()
;     (interactive)
;     (set-face-background 'modeline "LightBlue")
; 	(recompile)))

(global-set-key (kbd "<f5>")  'compile-again)
(global-set-key (kbd "C-<f5>") 'open-compilation-buffer)


; http://emacswiki.org/emacs/CompileCommand - (Recompiling)
; (global-set-key [(control c) (c)] 'compile-again)

(setq compilation-last-buffer nil)
(defun compile-again (pfx)
  """Run the same compile as the last time.

     If there was no last time, or there is a prefix argument, this acts like
     M-x compile.
  """
 (interactive "p")
 (save-some-buffers 1)
 (if compilation-last-buffer
     (progn
       (set-buffer compilation-last-buffer)
	   (modeline-cancel-timer)
	   (set-face-background 'modeline "LightBlue")
	   (recompile)
	   )
   (call-interactively 'compile)))
