; -*- mode:lisp -*-
; author: David.Villa@uclm.es

;| A very good customization for tabbar-mode.
;|
;| - Better faces for tabs.
;| - Separate buffers in three independent groups: user files, dired and messages.
;|
;| .. image:: http://crysol.org/files/emacs-tabbar.png
;|
;| Keystrokes:
;|
;| - M-<n> to change among the first 10 tabs
;| - C-S-o and C-S-p to change among tabs
;| - C-S-i and C-S-j to change among groups

(custom-set-faces
 '(tabbar-default
   ((t (:inherit variable-pitch :background "gray94" :foreground "gray25" :height 0.8))))
 '(tabbar-highlight
   ((t (:foreground "blue"))))
 '(tabbar-selected
   ((t (:inherit tabbar-default :background "gray95" :weight bold
;				 :box '(:line-width 8 :color "white" :style released-button)
				 ))))
 '(tabbar-unselected
   ((t (:inherit tabbar-default :background "gray85" :foreground "gray30"
;				 :box '(:line-width 1 :color "gray80" :style nil)
				 ))))
 '(tabbar-separator
   ((t (:background "gray50" :height 1.2)))
   )
 '(tabbar-button
   (( t (:box nil))))
 )

(require 'tabbar)
(tabbar-mode 1)

(setq tabbar-separator (quote (0.3)))
(setq tabbar-background-color "gray75")
(setq tabbar-cycle-scope (quote tabs))
(setq tabbar-use-images t)

(defun tabbar-group-message ()
  (message (concat "tabbar group: "
		   (car (funcall tabbar-buffer-groups-function))))
)

(defun tabbar-group-up ()
  (interactive)
  (tabbar-forward-group)
  (tabbar-group-message)
)

(defun tabbar-group-down ()
  (interactive)
  (tabbar-backward-group)
  (tabbar-group-message)
)

(global-set-key [(control shift t)] 'tabbar-mode)
(global-set-key [(control shift i)] 'tabbar-group-up)
(global-set-key [(control shift j)] 'tabbar-group-down)
(global-set-key [(control shift o)] 'tabbar-backward)
(global-set-key [(control shift p)] 'tabbar-forward)

(setq tabbar-buffer-groups-function
      (lambda ()
	(list (cond
	       ((string-equal "*" (substring (buffer-name) 0 1)) "Emacs")
	       ((eq major-mode 'dired-mode) "Dired")
	       ((eq major-mode 'compilation-mode) "Compilation")
	       (t "User")
	       ))))

;; ; https://gitorious.org/distopico/distopico-dotemacs/source/e6a5aaf153d7ade7180c696173e60e544a9ac0fc:emacs/modes/conf-tabbar.el#LNaN-NaN
;; ;; tabbar grouping method
;; (defun tabbar-buffer-groups-by-dir ()
;;         "Put all files in the same directory into the same tab bar"
;;         (with-current-buffer (current-buffer)
;;           (let ((dir (expand-file-name default-directory)))
;;             (cond ;; assign group name until one clause succeeds, so the order is important
;;              ((eq major-mode 'dired-mode)
;;               (list "Dired"))
;;              ((memq major-mode
;;                     '(help-mode apropos-mode Info-mode Man-mode))
;;               (list "Help"))
;;              ((string-match-p "\*.*\*" (buffer-name))
;;               (list "Misc"))
;;              (t (list dir))))))

;; (setq tabbar-buffer-groups-function 'tabbar-buffer-groups-by-dir)

;; (setq tabbar-buffer-groups-function
;;       (lambda ()
;; 	(let ((dir (expand-file-name default-directory)))
;; 	  (cond
;; 	   ((eq major-mode 'compilation-mode) (list "Compilation"))
;; 	   ((string-equal "*" (substring (buffer-name) 0 1)) (list "Emacs"))
;; 	   ((eq major-mode 'dired-mode) (list "Dired"))
;; 	   ((string-match-p "/.emacs.d/" dir) (list ".emacs.d"))
;; 	   (t (list dir)))
;; 	  )))


;--- from  http://emacswiki.org/emacs/TabBarMode
(defadvice tabbar-buffer-tab-label (after fixup_tab_label_space_and_flag activate)
  (setq ad-return-value (concat "  " (concat ad-return-value "  "))))


;--- From https://github.com/dholm/tabbar/blob/master/aquamacs-tabbar.el

;; you may redefine these:
(defvar tabbar-key-binding-modifier-list '(meta)
  "List of modifiers to be used for keys bound to tabs.
Must call `tabbar-define-access-keys' or toggle `tabbar-mode' for
changes to this variable to take effect.")

(defvar tabbar-key-binding-keys '((49 kp-1) (50 kp-2) (51 kp-3) (52 kp-4) (53 kp-5) (54 kp-6) (55 kp-7) (56 kp-8) (57 kp-9) (48 kp-0))
  "Codes of ten keys bound to tabs (without modifiers.
This is a list with 10 elements, one for each of the first 10
tabs.  Each element is a list of keys, either of which can be
used in conjunction with the modifiers defined in
`tabbar-key-binding-modifier-list'. Must call
`tabbar-define-access-keys' or toggle `tabbar-mode' for changes
to this variable to take effect.")

(defsubst tabbar-key-command (index)	; command name
  (intern (format "tabbar-select-tab-%s" index)))

(eval-when-compile (require 'cl))
(defun tabbar-define-access-keys (&optional modifiers keys)
  "Set tab access keys for `tabbar-mode'.
MODIFIERS as in `tabbar-key-binding-modifier-list', and
KEYS defines the elements to use for `tabbar-key-binding-keys'."
  (if modifiers (setq tabbar-key-binding-modifier-list modifiers))
  (if keys (setq tabbar-key-binding-keys keys))
  (loop for keys in tabbar-key-binding-keys
	for ni from 1 to 10 do
	(let ((name (tabbar-key-command ni)))
	  (eval `(defun ,name ()
		   "Select tab in selected window."
		   (interactive)
		   (tabbar-select-tab-by-index ,(- ni 1))))
	  ;; store label in property of command name symbol
	  (put name 'label
	       (format "%c" (car keys)))
	  (loop for key in keys do
		(define-key tabbar-mode-map
		  (vector (append
			   tabbar-key-binding-modifier-list
			   (list key)))
		  name)))))

(defun tabbar-select-tab-by-index (index)
  ;; (let ((vis-index (+ index (or (get (tabbar-current-tabset) 'start) 0))))
  (unless (> (length (tabbar-tabs (tabbar-current-tabset))) 1)
    ;; better window (with tabs)in this frame?

    (let ((better-w))
      (walk-windows (lambda (w)
		      (and (not better-w)
			   (with-selected-window w
			     (if (> (length (tabbar-tabs (tabbar-current-tabset t))) 1)
				 (setq better-w w)))))
		    'avoid-minibuf (selected-frame))
      (if better-w (select-window better-w))))

  (tabbar-window-select-a-tab
   (nth index (tabbar-tabs (tabbar-current-tabset)))))

(defun tabbar-window-select-a-tab (tab)
  "Select TAB"
  (let ((one-buffer-one-frame nil)
	(buffer (tabbar-tab-value tab)))
    (when buffer

      (set-window-dedicated-p (selected-window) nil)
      (let ((prevtab (tabbar-get-tab (window-buffer (selected-window))
				     (tabbar-tab-tabset tab)))
	    (marker (cond ((bobp) (point-min-marker))
				((eobp) (point-max-marker))
				(t (point-marker)))))
	(set-marker-insertion-type marker t)
;	(assq-set prevtab marker 'tab-points)
	)
      (switch-to-buffer buffer)
;      (let ((new-pt (cdr (assq tab tab-points))))
;	(and new-pt
;	     (eq (marker-buffer new-pt) (window-buffer (selected-window)))
;	     (let ((pos (marker-position new-pt)))
;	       (unless (eq pos (point))
;		 (if transient-mark-mode
;		     (deactivate-mark))
;		 (goto-char pos))
;	       (set-marker new-pt nil) ;; delete marker
;	       )))
	  )))
; (marker-insertion-type (cdr (car tab-points)))

(tabbar-define-access-keys)


;--- start with only a window
(run-with-idle-timer 0 nil (quote delete-other-windows))



;; (setq-default mode-line-format
;;     (list
;;      '(:eval (when (tabbar-mode-on-p)
;;                (concat (propertize (car (funcall tabbar-buffer-groups-function)) 'face 'font-lock-string-face) " > ")))
;;   ))
