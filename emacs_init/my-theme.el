;; #####################################################################
;; 中英文等宽|
;; HelloWorld|
;; frame 相关| 被注释掉的那些语句在打开一个新的 frame 时会失效, 不能用
;; #####################################################################
;; (set-face-attribute 'default nil :font "Yuan Mo Wen:pixelsize=24")
(add-to-list 'default-frame-alist '(font . "Yuan Mo Wen:pixelsize=16"))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(alpha . 90))
;; (add-to-list 'default-frame-alist '(alpha . 100))
;; (add-to-list 'default-frame-alist '(background-color . "#000000"))
(add-to-list 'default-frame-alist '(background-color . "#131926"))
(add-to-list 'default-frame-alist '(foreground-color . "#ffffff"))
;; (set-foreground-color "#ffffff")
;; (set-background-color "#131926")

;; #####################################################################
;; `basic'
;; #####################################################################
(setq inhibit-startup-message 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

(if (> (string-to-number emacs-version) 26)
    (global-display-line-numbers-mode t)
  (global-linum-mode t))
(setq column-number-mode t)

(setq blink-cursor-mode nil)
;; (setq blink-cursor-delay 1)

(setq frame-title-format "%b")

(setq display-time-24hr-format t)
(setq display-time-format "%H:%M:%S %m-%d %a")
(setq display-time-interval 1)
(display-time-mode t)


;; #####################################################################
;; `global-keywords'
;; #####################################################################
(global-font-lock-mode t)

(mapc (lambda (mode)
        (font-lock-add-keywords
         mode
         '(("\\<\\(FIXME\\|TODO\\|NOTE\\):" ; `:` is useful for org-todo
	    1 'font-lock-warning-face prepend))))
      '(python-mode emacs-lisp-mode c-mode rustic-mode org-mode))



(provide 'my-theme)
