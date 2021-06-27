;;; my-utils.el -*- lexical-binding: t -*-

(defun shell-safe-filename (filename)
  (format "\"%s\"" (replace-regexp-in-string "\\([\"]\\)" "\\\\\\1" filename)))


(defmacro generate-easy-insert-func (name pairs)
  "NOTE 1: do not use read syntax: #s(hash-table test equal)
NOTE 2: because `name' and basic elements of `pairs' are all strings,
so there is no variable confliction, unintern symbol is not needed,
local variable `dict' and `content' are safe.
TODO: use string= instead of equal, since we only use string."
  `(let ((dict (make-hash-table :test 'equal)))
     (dolist (pair ,pairs)
       (puthash (car pair) (cdr pair) dict))
     (defalias (intern ,(concat "easy-insert-" name))
       (lambda ()
	 (interactive)
	 (let ((content
		(gethash (completing-read "Type wanted: " dict) dict)))
	   (if content
	       (princ content (current-buffer))
	     (message "Unknown type!")))))))




(provide 'my-utils)
