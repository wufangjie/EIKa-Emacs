;; #####################################################################
;; `eshell'
;; NOTE: use paragraph level move instead of outline-mode
;; #####################################################################
(setq eshell-save-history-on-exit t
      eshell-history-size 4096
      eshell-hist-ignoredups t)

(setq eshell-visual-subcommands
      '(("git" "log")))

(defvar eshell-histignore
  '("^\\(cd\\|git\\|svn\\|cargo\\|h2r\\|find\\|grep\\|ln\\)\\(\\(\\s \\)+.*\\)?$"
    "^("
    "^xmodmap ~/\\.xmodmap$"
    "^sudo apt-get \\(update\\|upgrade\\|autoremove\\)$"
    "^man "
    "^ new "
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


;; Usage:
;; 1. put following record to ~/.emacs.d/eshell/history
;;    h2r sys du -ah --max-depth 1 ~/
;;    h2r cargo RUST_BACKTRACE=1 cargo run
;;    ...
;; 2. insert `h2r s` in *eshell*, then press `Alt + p` to lookup matches in the history
;; 3. modify it or not, then press RET to run
;; NOTE: add h2r to eshell-histignore
(defun h2r (sub command &rest args)
  (eshell-do-eval
   (eshell-parse-command command args) t))

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
