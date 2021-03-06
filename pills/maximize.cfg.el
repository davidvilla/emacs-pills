; -*- mode:lisp -*-

;| Maximize the Emacs X window.
;|
;| Keystrokes:
;|
;| - F11: toggles fullscreen.
;| - C-F11: toggles vertical maximization.

(defvar old-fullscreen)

(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
       (set-frame-parameter nil 'fullscreen
                            (if (equal 'fullboth current-value)
                                (if (boundp 'old-fullscreen) old-fullscreen nil)
                                (progn (setq old-fullscreen current-value)
                                       'fullboth)))))
;
(defun vertical-max (&optional f)
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
			 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))
;
(global-set-key [f11] 'toggle-fullscreen)
(global-set-key [C-f11] 'vertical-max)
