; -*- mode:lisp -*-

;| Convenience configuration for ``compile`` command.
;|
;| See the screencast:
;|
;|    |compile-screencast|_
;|
;| .. |compile-screencast| image:: http://i3.ytimg.com/vi/ZnWN7htqT48/2.jpg?time=1371658070649
;| .. _compile-screencast: http://youtu.be/ZnWN7htqT48
;|
;| Features:
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
;| - C-F5 opens the compilation buffer
;|
;| (new in version 0.20130327)

; References:
; - http://vwood.github.com/emacs-compile-on-save.html
; - http://comments.gmane.org/gmane.emacs.devel/156498
; - http://emacswiki.org/emacs/CompileCommand (Xu Yuan)
; - http://emacswiki.org/emacs/CompileCommand (Recompiling)
; - http://rtime.felk.cvut.cz/~sojka/blog/compile-on-save/

(setq compilation-scroll-output 'first-error)

; automatically save buffer when ask for compilation
; http://stackoverflow.com/questions/2062492/save-and-compile-automatically
(setq compilation-ask-about-save nil)

(defvar modeline-timer)
(setq modeline-timer nil)

(defvar modeline-timeout)
(setq modeline-timeout "2 sec")

(defvar open-compilation-buffer-flag)

(defun modeline-set-color (color)
  "Colors the modeline"
  (interactive)
  (if (and (>= emacs-major-version 24) (>= emacs-minor-version 3))
    (set-face-background 'mode-line color)
    (set-face-background 'modeline color)
    )
  )

(defun modeline-cancel-timer ()
  (let ((m modeline-timer))
	(when m
	  (cancel-timer m)
	  (setq modeline-timer nil))))

(defun modeline-delayed-clean ()
  (modeline-cancel-timer)
  (setq modeline-timer
		(run-at-time modeline-timeout nil 'modeline-set-color nil)))

(defun compilation-exit-hook (status code msg)
  ;; If M-x compile exists with a 0
;  (defvar current-frame)
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
	  (if open-compilation-buffer-flag
	      (open-compilation-buffer)
	      (modeline-delayed-clean)
	    )))

;  (setq current-frame (car (car (cdr (current-frame-configuration)))))
;  (select-frame-set-input-focus current-frame)
  ;; Always return the anticipated result of compilation-exit-message-function
  (cons msg code))

(defadvice compile (around compile/save-window-excursion first () activate)
  (save-window-excursion ad-do-it))

(defadvice recompile (around compile/save-window-excursion first () activate)
  (save-window-excursion ad-do-it))

; FIXME: nobody calls this
(defun recompile-if-not-in-progress ()
  (let ((buffer (compilation-find-buffer)))
    (unless (get-buffer-process buffer)
      (recompile)))
  )

(defun interrupt-compilation ()
  (setq compilation-exit-message-function 'nil)
  (ignore-errors
    (progn (delete-process "*compilation*")
  	   (modeline-set-color "DeepSkyBlue")
  	   (message "previous compilation aborted!")
  	   (sit-for 1.5)
  	   ))

; (ignore-errors
;   (progn (process-kill-without-query
; 	    (get-buffer-process (get-buffer "*compilation*")))
; 	   (modeline-set-color "DeepSkyBlue")))

;  (condition-case nil
;      (process-kill-without-query
;       (get-buffer-process (get-buffer "*compilation*")))
;    (error (modeline-set-color "DeepSkyBlue")))
  )


(defun interrupt-and-recompile ()
  "Interrupt old compilation, if any, and recompile."
  (interactive)
  (interrupt-compilation)
  (recompile)
)

(setq compilation-last-buffer nil)
(defun compile-again ()
   "Run the same compile as the last time.
    If there was no last time, or there is a prefix argument, this acts like
      M-x compile."
   (interactive)

   (setq compilation-process-setup-function
	 (lambda() (progn (modeline-cancel-timer)
			  (setq compilation-exit-message-function 'compilation-exit-hook)
			  (modeline-set-color "LightBlue"))))

   (if compilation-last-buffer
       (progn
;	 (condition-case nil
;	     (set-buffer compilation-last-buffer)
;	   (error 'ask-new-compile-command))
	 (modeline-cancel-timer)
	 (interrupt-and-recompile)
	 )
     (call-interactively 'compile)
     )
   )

(global-set-key (kbd "<f5>")  'save-and-compile-again)
(global-set-key (kbd "s-<f5>") 'ask-new-compile-command)
(global-set-key (kbd "C-<f5>") 'open-compilation-buffer)

(defun save-and-compile-again ()
  (interactive)
  (save-some-buffers 1)
  (setq open-compilation-buffer-flag t)
  (compile-again)
  )

(defun ask-new-compile-command ()
  (interactive)
  (setq compilation-last-buffer nil)
  (save-and-compile-again)
  )

(defun open-compilation-buffer()
  (interactive)
  (display-buffer "*compilation*")
  (modeline-delayed-clean)
  )


;-- compile-on-save minor mode ---

(define-minor-mode compile-on-save-mode
  "Minor mode to automatically compile whenever the current buffer is
  saved. When there is ongoing compilation, nothing happens."
  :lighter " CoS"
  (if compile-on-save-mode
      (progn (make-local-variable 'after-save-hook)
	     (add-hook 'after-save-hook 'activate-compile-on-save nil t))
    (kill-local-variable 'after-save-hook)))

(defun activate-compile-on-save()
  (interactive)
  (message "Compiling after saving...")
  (setq open-compilation-buffer-flag nil)
  (compile-again))
