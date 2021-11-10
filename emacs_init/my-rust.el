;; (setq-default rustic-format-on-save t)
;; (setq-default rustic-lsp-format t)
(setq-default rustic-format-display-method 'ignore)
(setq-default rustic-format-trigger 'on-compile)
;; (setq-default rustic-format-trigger 'on-save)
;; (setq-default rustic-format-on-save-method 'rustic-format-buffer)

;; I hate to see fmt error when I save my unfinished code
;; (add-hook 'before-save-hook
;; 	  (lambda ()
;; 	    (when (eq major-mode 'rustic-mode)
;; 	      (rustic-format-file))))

;; NOTE: (rustic-compilation-process-live) will prompt minibuffer asking
(defun rustic-cargo-fmt-and-test ()
  (interactive)
  (rustic-cargo-fmt)
  (let* ((command (list rustic-cargo-bin "test"))
         (c (append command (split-string (setq rustic-test-arguments
						"-- --nocapture"))))
         (buf rustic-test-buffer-name)
         (proc rustic-test-process-name)
         (mode 'rustic-cargo-test-mode))
    (rustic-compilation c (list :buffer buf :process proc :mode mode))))

(defun rustic-cargo-fmt-and-current-test ()
  ;; NOTE: cursor must on function name row
  (interactive)
  (beginning-of-defun)
  (rustic-format-file)
  (-if-let (test-to-run (rustic-cargo--get-test-target))
      (let* ((command (list rustic-cargo-bin "test" test-to-run))
             (c (append command (split-string (setq rustic-test-arguments
						    "-- --nocapture"))))
             (buf rustic-test-buffer-name)
             (proc rustic-test-process-name)
             (mode 'rustic-cargo-test-mode))
        (rustic-compilation c (list :buffer buf :process proc :mode mode)))
    (message "Could not find test at point.")))

(add-hook 'rustic-mode-hook
	  (lambda ()
	    (local-unset-key (kbd "C-c C-c C-t"))
	    (local-set-key (kbd "C-c C-c C-t") 'rustic-cargo-fmt-and-test)
	    (local-unset-key (kbd "C-c C-c C-c"))
	    (local-set-key (kbd "C-c C-c C-c") 'rustic-cargo-fmt-and-current-test)
	    ))

;; the C-c C-c prefix seems foolish
(provide 'my-rust)