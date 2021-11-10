;; #####################################################################
;; `eshell'
;; NOTE: use paragraph level move instead of outline-mode
;; #####################################################################
(setq eshell-save-history-on-exit t
      eshell-history-size 4096
      eshell-hist-ignoredups t)

(defvar eshell-histignore
  '("^\\(cd\\|git\\|svn\\|g\\+\\+\\|cc\\|nvcc\\)\\(\\(\\s \\)+.*\\)?$"
    "^("
    "^\\./a\\.out$"
    "^xmodmap ~/\\.xmodmap$"
    "^sudo apt-get \\(update\\|upgrade\\|autoremove\\)$"
    "^man "
    "^cargo new "
    "^\\(sudo \\)?pip[23]? \\(list\\|show\\|search\\)"
    " -\\(-version\\|[Vv]\\)$"
    ))

(setq eshell-input-filter
      #'(lambda (str)
	  (let ((regex eshell-histignore))
	    (not
	     (catch 'break
	       (while regex
		 (if (string-match (pop regex) str)
		     (throw 'break t))))))))



;; #####################################################################
;; `term-mode'
;; #####################################################################
(defun toggle-term-mode ()
  (interactive)
  (if (term-in-line-mode)
      (term-char-mode)
    (term-line-mode)))

(add-hook 'term-mode-hook
	  (lambda ()
	    (term-line-mode)
	    (local-set-key (kbd "C-c C-j") 'toggle-term-mode)))


(provide 'my-shell)
