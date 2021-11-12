;;; my-rust.el ergonomic enhance for rust programming.

;; Version: 0.1.0
;; URL: https://github.com/wufangjie/EIKa-Emacs/blob/main/emacs_init/my-rust.el
;; Package-Requires: rustic

;; enhances:
;; 1. auto fmt before run, test, current-test
;; 2. can call current-test in test body rather than must in fn row
;; 3. crate-level grep

;; (setq-default rustic-format-on-save t)
;; (setq-default rustic-format-display-method 'ignore)
;; (setq-default rustic-format-trigger 'on-compile) ;'on-save
;; (setq-default rustic-format-on-save-method 'rustic-format-buffer)

;; I hate to see fmt error when I save my unfinished code
;; (add-hook 'before-save-hook
;; 	  (lambda ()
;; 	    (when (eq major-mode 'rustic-mode)
;; 	      (rustic-format-file))))

(defun wait-proc (proc)
  (while (eq (process-status proc) 'run)
    (sit-for 0.1))
  (zerop (process-exit-status proc)))

(defun rustic-cargo-fmt-then-run (&optional arg)
  (interactive "P")
  (wait-proc (rustic-cargo-fmt))
  (let ((command (if arg "cargo run --release" "cargo run")))
    (rustic-run-cargo-command command (list :mode 'rustic-cargo-run-mode))))

(defun rustic-cargo-fmt-then-test ()
  (interactive)
  (wait-proc (rustic-cargo-fmt))
  (rustic-cargo-test-run rustic-test-arguments))

(defun rustic-cargo-fmt-then-current-test ()
  (interactive)
  (save-excursion
    (beginning-of-defun)
    (rustic-format-file) ; NOTE: no wait here
    (rustic-cargo-current-test)))

(defun rustic-crate-grep ()
  (interactive)
  (let ((dir (locate-dominating-file
	      (buffer-file-name (current-buffer)) "Cargo.toml")))
    (if dir
	(let ((buffer (get-buffer-create "*rust grep*")))
	  (shell-command
	   (format "grep -rn \"%s\" %s --exclude-dir=target/ --exclude-dir=.git/ --exclude=\\*~"
		   (read-from-minibuffer "Crate grep: ") dir)
	   buffer)
	  (with-current-buffer buffer (grep-mode))
	  (if (= (count-windows) 1)
	      (pop-to-buffer buffer)
	    (set-window-buffer (or (next-window) (window-at 0 0)) buffer)
	    (other-window 1)))
      (message "Could not find crate root!"))))

(add-hook 'rustic-mode-hook
	  (lambda ()
	    (setq rustic-test-arguments "-- --nocapture")
	    (local-unset-key (kbd "C-c C-c C-t"))
	    (local-set-key (kbd "C-c C-c C-t") 'rustic-cargo-fmt-then-test)
	    (local-unset-key (kbd "C-c C-c C-c"))
	    (local-set-key (kbd "C-c C-c C-c") 'rustic-cargo-fmt-then-current-test)
	    (local-unset-key (kbd "C-c C-c C-r"))
	    (local-set-key (kbd "C-c C-c C-r") 'rustic-cargo-fmt-then-run)
	    (local-set-key (kbd "C-c C-c C-g") 'rustic-crate-grep)
	    ))

(provide 'my-rust)
