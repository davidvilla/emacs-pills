; Install in command ‘revert-buffer’ with

;| revert-buffer customization: keep undo history

(defun revert-buffer-keep-undo (&rest -)
  "Revert buffer but keep undo history."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (insert-file-contents (buffer-file-name))
    (set-visited-file-modtime (visited-file-modtime))
    (set-buffer-modified-p nil)))

(setq revert-buffer-function 'revert-buffer-keep-undo)
