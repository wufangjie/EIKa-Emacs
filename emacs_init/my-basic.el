;;; my-basic.el

(show-paren-mode t)
(setq show-paren-style 'parentheses)

(setq scroll-margin 3)
(setq scroll-conservatively 10000)
(setq scroll-step 1)
;; (setq auto-window-vscroll nil)

(setq x-select-enable-clipboard t)  ; shared with clipboard

(setq make-backup-files nil)        ; no ~ file

(setq ediff-split-window-function 'split-window-horizontally)

(setq ring-bell-function 'ignore)

(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; #####################################################################
;; `coding-system'
;; #####################################################################
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)


;; #####################################################################
;; `global-kbd'
;; #####################################################################
;; use M-x suspend-frame instead,
;; if you use emacs -nw, you can not find emacs back, maybe?
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))

(global-unset-key (kbd "C-x C-n"))

;; ;; If you use emacs -nw, M-[ kbd will drive you crazy
;; (global-unset-key (kbd "M-{"))
;; (global-unset-key (kbd "M-}"))
;; (global-set-key (kbd "M-[") 'backward-paragraph)
;; (global-set-key (kbd "M-]") 'forward-paragraph)


(defun recenter-top-bottom-with-redraw ()
  (interactive)
  (recenter-top-bottom)
  (redraw-display))

(when window-system
  (global-set-key (kbd "C-l") 'recenter-top-bottom-with-redraw))


;; #####################################################################
;; `minor-mode-kbd'
;; #####################################################################
(add-hook 'compilation-shell-minor-mode-hook
	  (lambda ()
	    (let ((map compilation-shell-minor-mode-map))
	      (define-key map "\M-{" 'backward-paragraph)
	      (define-key map "\M-}" 'forward-paragraph))))


;; #####################################################################
;; `useful-interactive-functions'
;; #####################################################################
(defun set-transparency (n)
  "NOTE: only work when window-system"
  (interactive
   (list (round (string-to-number
		 (read-from-minibuffer "Set transparency (0~99): ")))))
  (let ((n (- 100 (min 99 (max 0 n)))))
    (set-frame-parameter (selected-frame) 'alpha `(,n ,n))))
;(set-transparency 10)


(defun set-line-spacing (n)
  "NOTE: only work when window-system"
  (interactive
   (list (round (string-to-number
		 (read-from-minibuffer "Set line-spacing (0~9): ")))))
  (setq-default line-spacing (if (> n 0) n)))


(defun exchange-buffer (&optional prefix)
  (interactive "P")
  (when (> (count-windows) 1)
    (let* ((winc (selected-window))
	   (win2 (if prefix (previous-window) (next-window)))
	   (winc-buf (window-buffer))
	   (win2-buf (window-buffer win2)))
      (set-window-buffer winc win2-buf)
      (set-window-buffer win2 winc-buf)
      (other-window (if prefix -1 1)))))


(defun toggle-split ()
  (interactive)
  (when (= (count-windows) 2)
    (let* ((winc (selected-window))
	   (win1 (window-at 0 0))
	   (win2 (if (eq winc win1) (next-window) winc))
	   (buf2 (window-buffer win2))
	   (is-up-down-style (= 0 (car (window-edges win2)))))
      (delete-other-windows win1)
      (if is-up-down-style (split-window-right) (split-window-below))
      (set-window-buffer (next-window) buf2)
      (if (eq winc win2) (other-window 1)))))


;; ####################################################################
;; `system-specific': `gnu/linux', `darwin', `windows-nt'
;; ####################################################################
(when (string-equal system-type "gnu/linux")
  (call-process-shell-command "xmodmap ~/.xmodmap" nil 0))

;; (defun clipboard-save ()
;;   "let terminal save selection to system clipboard"
;;   (interactive)
;;   (call-process-region (region-beginning) (region-end)
;; 		       "xsel" nil 0 nil "--clipboard" "--input"))



(provide 'my-basic)
