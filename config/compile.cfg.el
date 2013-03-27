; -*- mode:lisp -*-
; http://vwood.github.com/emacs-compile-on-save.html

;| Convenience configuration for ``compile`` command.
;|
;| - auto-save file before compilation, instead of asking.
;| - F5 to recompile
;| - C-F5 opens compilation buffer
;| - modeline background color represents compilation process:
;|
;|   - blue: compilation in progress
;|   - green:  compilation finished successfully
;|   - orange: compilation finished with warnnings
;|   - red: compilation finished with errors

(setq compilation-scroll-output 'first-error)

; automatically save buffer when ask for compilation
; http://stackoverflow.com/questions/2062492/save-and-compile-automatically
(setq compilation-ask-about-save nil)


; http://lazywithclass.posterous.com/emacs-functions-to-ease-tdd
(defun color-modeline(color)
  "Colors the modeline, green success red failure"
  (interactive)
  (set-face-background 'modeline color))

(defun no-color-modeline()
  "No color for the modeline"
  (interactive)
  (set-face-background 'modeline nil))


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


(defun compilation-exit-hook (status code msg)
  ;; If M-x compile exists with a 0
  (if (and (eq status 'exit) (zerop code))
    (progn
      (if (string-match "warning:" (buffer-string))
	  (color-modeline "orange")
	  (progn (color-modeline "YellowGreen")
	   (run-at-time "2 sec" nil 'no-color-modeline)))
      (delete-windows-on (get-buffer "*compilation*"))
      )
    (color-modeline "OrangeRed"))
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
;(defadvice compile (around compile/save-window-excursion first () activate)
;  (save-window-excursion ad-do-it))

;(defadvice recompile (around compile/save-window-excursion first () activate)
;  (save-window-excursion ad-do-it))

(defun recompile-after-save()
  (message "Compiling after saving...")
;  (interactive)
;  (ignore-errors (kill-compilation))
  (recompile)
  )
;
; (add-to-list 'after-save-hook 'recompile-after-save)


(global-set-key (kbd "<f5>")
  (lambda()
    (interactive)
    (set-face-background 'modeline "LightBlue")
    (recompile)))

(global-set-key (kbd "C-<f5>")
  (lambda()
    (interactive)
    (display-buffer "*compilation*")
    (run-at-time "2 sec" nil 'no-color-modeline)))
