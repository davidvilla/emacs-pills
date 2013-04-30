; -*- mode:lisp -*-

;| Convenience configuration for ``compile`` command.
;|
;| See the screencast:
;|
;|    |compile-screencast|_
;|
;| .. |compile-screencast| image:: http://i4.ytimg.com/vi/34B3mkPj01s/3.jpg?time=1365699591540
;| .. _compile-screencast: http://youtu.be/34B3mkPj01s
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
; - from http://emacswiki.org/emacs/CompileCommand (Xu Yuan)
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

; http://lazywithclass.posterous.com/emacs-functions-to-ease-tdd
(defun modeline-set-color (color)
  "Colors the modeline"
  (interactive)
;  (ignore-errors (set-face-background 'mode-line color))
;  (ignore-errors (set-face-background 'modeline color))  ; < 24.3.1

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
;  (select-frame-set-input-focus current-frame)
  ;; Always return the anticipated result of compilation-exit-message-function
  (cons msg code))
;
(setq compilation-exit-message-function 'compilation-exit-hook)

(defadvice compile (around compile/save-window-excursion first () activate)
    (save-window-excursion ad-do-it))

(defadvice recompile (around compile/save-window-excursion first () activate)
   (save-window-excursion ad-do-it))


(defun save-and-compile-again ()
  (interactive)
  (save-some-buffers 1)
  (compile-again)
  )

(defun recompile-if-not-in-progress ()
  (let ((buffer (compilation-find-buffer)))
    (unless (get-buffer-process buffer)
      (recompile)))
  )

(defun interrupt-compilation ()
    (ignore-errors
    (process-kill-without-query
      (get-buffer-process
        (get-buffer "*compilation*"))))
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
	 (lambda() (modeline-set-color "LightBlue")))

   (if compilation-last-buffer
       (progn
	 (set-buffer compilation-last-buffer)
	 (modeline-cancel-timer)
	 (recompile-if-not-in-progress)
;	 (interrupt-and-recompile)
	 )
     (call-interactively 'compile)
     )
   )

(defun ask-new-compile-command ()
  (interactive)
  (setq compilation-last-buffer nil)
  (compile-again)
  )

(global-set-key (kbd "<f5>")  'save-and-compile-again)
(global-set-key (kbd "s-<f5>") 'ask-new-compile-command)
(global-set-key (kbd "C-<f5>") 'open-compilation-buffer)


(define-minor-mode compile-on-save-mode
  "Minor mode to automatically compile whenever the current buffer is
  saved. When there is ongoing compilation, nothing happens."
  :lighter " CoS"
  (if compile-on-save-mode
      (progn  (make-local-variable 'after-save-hook)
	      (add-hook 'after-save-hook 'activate-compile-on-save nil t))
    (kill-local-variable 'after-save-hook)))

(defun activate-compile-on-save()
  (interactive)
  (message "Compiling after saving...")
  (compile-again))
