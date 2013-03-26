; -*- mode:lisp -*-
; http://vwood.github.com/emacs-compile-on-save.html

;| Convenience configuration for ``compile`` command.
;|
;| - auto-save file before compilation, instead of asking.
;| - modeline red/green showing compilation result (for 2 seconds)
;| - F5 to run compile command.

(setq compilation-scroll-output 'first-error)

; automatically save buffer when ask for compilation
; http://stackoverflow.com/questions/2062492/save-and-compile-automatically
(setq compilation-ask-about-save nil)


; http://lazywithclass.posterous.com/emacs-functions-to-ease-tdd
(defun color-modeline(exit-value)
  "Colors the modeline, green success red failure"
  (interactive)
  (let (test-result-color)
    (if (= exit-value 0)
        ((setq test-result-color "Green")
	 (run-at-time "2 sec" nil 'no-color-modeline))
      (setq test-result-color "Red"))
    (set-face-background 'modeline test-result-color)))

(defun no-color-modeline()
  "No color for the modeline"
  (interactive)
  (set-face-background 'modeline nil))


; from http://emacswiki.org/emacs/CompileCommand (Xu Yuan)
(defun notify-compilation-result(buffer msg)
  "Notify that the compilation is finished,
close the *compilation* buffer if the compilation is successful,
and set the focus back to Emacs frame"
  (if (string-match "^finished" msg)
    (progn
;     (delete-windows-on buffer)
     (color-modeline 0))
    (color-modeline 1))
  (setq current-frame (car (car (cdr (current-frame-configuration)))))
  (select-frame-set-input-focus current-frame)
  )


(add-to-list 'compilation-finish-functions 'notify-compilation-result)

;http://vwood.github.com/emacs-compile-on-save.html
;; Prevent compilation buffer from showing up
(defadvice compile (around compile/save-window-excursion first () activate)
  (save-window-excursion ad-do-it))

;; Bury the compilation buffer when compilation is finished and successful.
(add-to-list 'compilation-finish-functions
             (lambda (buffer msg)
               (when
                 (bury-buffer buffer)
                 (replace-buffer-in-windows buffer))))

(global-set-key (kbd "<f5>") 'compile)
