; -*- mode:lisp -*-

;| Convenience configuration for ``compile`` command. See the `compile-screencast`_.
;|
;| .. _compile-screencast: http://youtu.be/34B3mkPj01s
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
;| - F5 compile (using last given compile command)
;| - Super-F5 asks for a new compile command
;| - C-F5 opens compilation buffer
;|
;| (new in version 0.20130327)

; References:
; - http://vwood.github.com/emacs-compile-on-save.html
; - http://comments.gmane.org/gmane.emacs.devel/156498
; - from http://emacswiki.org/emacs/CompileCommand (Xu Yuan)
; - http://emacswiki.org/emacs/CompileCommand (Recompiling)

(setq compilation-scroll-output 'first-error)

; automatically save buffer when ask for compilation
; http://stackoverflow.com/questions/2062492/save-and-compile-automatically
(setq compilation-ask-about-save nil)

(defvar modeline-timer)
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

(defun open-compilation-buffer()
    (interactive)
    (display-buffer "*compilation*")
	(modeline-delayed-clean)
	)

(defun compilation-exit-hook (status code msg)
  ;; If M-x compile exists with a 0
  (defvar current-frame)
  (if (and (eq status 'exit) (zerop code))
    (progn
      (if (string-match "warning:" (buffer-string))
	  (modeline-set-color "orange")
          (modeline-set-color "YellowGreen")
      )
      (other-buffer (get-buffer "*compilation*"))
      (modeline-delayed-clean)
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

;(defun hide-compilation-buffer
;  (defadvice compile (around compile/save-window-excursion first () activate)
;    (save-window-excursion ad-do-it))
;  )

; (hide-compilation-buffer)

(defadvice recompile (around compile/save-window-excursion first () activate)
   (save-window-excursion ad-do-it))

(setq compilation-last-buffer nil)
(defun compile-again (pfx)
  """Run the same compile as the last time.

     If there was no last time, or there is a prefix argument, this acts like
     M-x compile.
  """
 (save-some-buffers 1)
 (interactive "p")
 (if compilation-last-buffer
     (progn
       (set-buffer compilation-last-buffer)
	   (modeline-cancel-timer)
	   (set-face-background 'modeline "LightBlue")
	   (recompile)
	   )
   (call-interactively 'compile)))

(defun ask-new-compile-command ()
  (interactive)
  (setq compilation-last-buffer nil)
  (compile-again 1)
  )


(global-set-key (kbd "<f5>")  'compile-again)
(global-set-key (kbd "s-<f5>") 'ask-new-compile-command)
(global-set-key (kbd "C-<f5>") 'open-compilation-buffer)
