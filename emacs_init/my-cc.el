;;; my-cc.el -*- lexical-binding: t -*-

(require 'my-utils)
(require 'comint)


;; TODO: cd is needed, but how? (when I switch buffer and then compile, it may tell me: "No such file or directory", and I need to run it second time, then it works)

(defvar cc-compile-proc "cc")
(defvar cc-compile-args "")


(defun cc-mode-make-comint ()
  ;; use eshell to cross platform? Seems impossible
  (interactive)
  (let* ((proc-name "cc terminal")
	 (buffer-name (format "*%s*" proc-name))
	 (window (if (= (count-windows) 1)
		     (split-window-right)
		   (next-window))))
    (unless (comint-check-proc buffer-name)
      ;; I don't know why they use apply instead of directly calling
      (progn (make-comint-in-buffer proc-name nil "bash")
      	     (setq comint-prompt-read-only t)))
    (set-window-buffer window buffer-name)
    buffer-name))


(defun cc-mode-send-string (s ask-for-confirm)
  (let ((process (get-buffer-process (cc-mode-make-comint)))
	(ss (if ask-for-confirm
		(read-string "Send String: " s)
	      s)))
    (other-window 1)
    ;; (insert ss) ;; error
    (comint-send-string process ss)
    (comint-send-input) ; newline
    (other-window -1)))


(defun get-outfile (filename)
  ;; (expand-file-name "a.out" (file-name-directory filename)))
  (format "%s.out" filename))


(defun cc-mode-compile (&optional ask-for-confirm)
  (interactive "P")
  (let* ((filename (buffer-file-name (current-buffer)))
	 (outfile (get-outfile filename)))
    (message "only for debug, current file: %s" filename) ; for debug
    (cc-mode-send-string (format "%s %s %s -o %s"
				 cc-compile-proc
				 (shell-safe-filename filename)
				 cc-compile-args
				 (shell-safe-filename outfile))
			 ask-for-confirm)))


(defun cc-mode-run (&optional ask-for-confirm)
  (interactive "P")
  (let ((outfile (get-outfile (buffer-file-name (current-buffer)))))
    (cc-mode-send-string (shell-safe-filename outfile)
			 ask-for-confirm)))


;; TODO: gdb
(defun cc-mode-gdb ()
  (interactive)
  (cc-mode-send-string ""))


(defun cc-mode-doc-on-word ()
  (interactive)
  (manual-entry (current-word)))


(add-hook 'c-mode-hook
	  (lambda ()
	    (c-set-style "linux")
	    (local-set-key (kbd "C-c d") 'cc-mode-doc-on-word)
	    (local-set-key (kbd "C-c C-c") 'cc-mode-compile)
	    (local-set-key (kbd "C-c C-r") 'cc-mode-run)
	    ;;(local-set-key (kbd "C-c C-g") 'cc-mode-gdb)
	    ))


(add-hook 'c-mode-common-hook
	  (lambda ()
	    (c-set-style "linux")
	    (local-set-key (kbd "C-c d") 'cc-mode-doc-on-word)
	    (local-set-key (kbd "C-c C-c") 'cc-mode-compile)
	    (local-set-key (kbd "C-c C-r") 'cc-mode-run)
	    ;;(local-set-key (kbd "C-c C-g") 'cc-mode-gdb)
	    ))


(provide 'my-cc)
