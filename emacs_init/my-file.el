(require 'my-utils)


;; #####################################################################
;; `open-file-with-default-application'
;; #####################################################################
(defvar file-open-command
  (cond ((string= system-type "gnu/linux") "xdg-open")
	((string= system-type "darwin") "open")
	((string= system-type "windows-nt") "call")
	(t nil)))


(defun open-file-with-default-application (name)
  (interactive
   (list (read-file-name "Open file: ")))
  (if file-open-command
      (if (file-exists-p name)
	  (call-process-shell-command
	   (format "%s %s"
		   file-open-command
		   (shell-safe-filename (expand-file-name name)))
	   nil 0)
	(message "Invalid filename!"))
    (message "Unknown system!")))


;; #####################################################################
;; `dired-mode'
;; #####################################################################
(add-hook 'dired-mode-hook
	  (lambda ()
	    (setq dired-actual-switches "-la")
	    ;; (setq dired-recursive-copies "always")
	    ;; (setq dired-recursive-deletes "always")
	    ;; seems did not work, comment them

	    (local-set-key
	     (kbd "C-RET")
	     (lambda ()
	       (interactive)
	       (let ((name (dired-file-name-at-point)))
		 (if (file-directory-p name)
		     (dired-find-file)
		   (open-file-with-default-application name)))))

	    (local-set-key
	     (kbd "s")
	     (lambda ()
	       (interactive)
	       (when dired-sort-inhibit
		 (error "Cannot sort this Dired buffer!"))
	       (dired-sort-other
		(read-string "ls switches (must contain -l): "
			     dired-actual-switches))))
	    ))


;; #####################################################################
;; `ibuffer'
;; #####################################################################
(global-set-key (kbd "C-x C-b") 'ibuffer)


(defun ibuffer-display-buffer-in-next-window ()
  (interactive)
  (when (= (count-windows) 1) (split-window-right))
  (let* ((buf (ibuffer-current-buffer t))
	 (curwin (selected-window))
	 (nxtwin (next-window))
	 (buf0 (window-buffer curwin)))
    (other-window 1)
    (switch-to-buffer buf)
    (other-window -1)))

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-o") 'ibuffer-display-buffer-in-next-window)
	    (local-set-key (kbd "U") 'ibuffer-unmark-all)))



(provide 'my-file)
