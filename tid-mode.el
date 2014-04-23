(defun tid-p ()
  (and
   (> (length (buffer-file-name)) 4)
   (string-equal (substring (buffer-file-name) -4) ".tid")))

(defun tid-time ()
  "If called in a tiddler file, this function updates the metadata to
  reflect the modification time."
  (interactive)
  (when (tid-p)
      (save-excursion
	(goto-char (point-min))
	(search-forward "modified: ")
	(beginning-of-line)
	(kill-line)
	(insert (format-time-string "modified: %Y%m%d%H%M%S%3N")))))


(defun tid-save ()
  "If a .tid file is saved, call tid-time to update the metadata."
  (add-hook 'before-save-hook 'tid-time))
(define-derived-mode tid-mode text-mode "TW"
   "A major mode for editing TiddlyWiki5 (.tid) files."
   (add-hook 'tid-mode-hook 'turn-on-orgstruct)
   (add-hook 'tid-mode-hook 'subword-mode)
   (add-hook 'tid-mode-hook 'tid-save))

(add-to-list 'auto-mode-alist '("\\.tid\\'" . tid-mode))

(provide 'tid-mode)
