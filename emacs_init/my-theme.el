;; #####################################################################
;; 中英文等宽|
;; HelloWorld|
;; frame 相关| 被注释掉的那些语句在打开一个新的 frame 时会失效, 不能用
;; #####################################################################
;(set-face-attribute 'default nil :font "Yuan Mo Wen:pixelsize=24")
(add-to-list 'default-frame-alist '(font . "Yuan Mo Wen:pixelsize=22"))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(alpha . 90))
;;(add-to-list 'default-frame-alist '(alpha . 100))
;;(add-to-list 'default-frame-alist '(background-color . "#000000"))
(add-to-list 'default-frame-alist '(background-color . "#131926"))
(add-to-list 'default-frame-alist '(foreground-color . "#ffffff"))
;(set-foreground-color "#ffffff")
;(set-background-color "#131926")



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
;(setq blink-cursor-delay 1)


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
         '(("\\<\\(FIXME\\|TODO\\|NOTE\\):"
	    1 'font-lock-warning-face prepend))))
      '(python-mode emacs-lisp-mode c-mode)) ; org-mode
;; FIXME TODO : when keyword occur in org-mode's outline, incorrect color
;; in /usr/local/share/emacs/26.1/lisp/org/
;; org.el.gz defun org-context


;; '(("^[^*]*?\\<\\(FIXME\\|TODO\\|NOTE\\)"
(font-lock-add-keywords
 'org-mode
 ;;'(("^[^*]*?\\<\\(FIXME\\|TODO\\|NOTE\\)"
 '(("\\<\\(FIXME\\|TODO\\|NOTE\\):" . 'font-lock-warning-face)))


;; #####################################################################
;; `color'
;; useful functions: list-color-display list-faces-display describe-face
;; #####################################################################

(let ((white          "#ffffff")
      (black          "#000000") ; "#131926"
      (gray           "#625b57") ;  555753 666666
      (red            "#e31b1c")
      (green          "#66cd00")
      (pale-green     "#9aff9a")
      (yellow         "#ffec8b")
      (gold           "#ffb90f")
      (blue           "#4682b4")
      (magenta        "#ffa07a") ;;ff9969 ;ff9900
      (pink           "#ffbbff")
      (pale           "#d3d3d3")
      (cyan           "#00ffff")
      (brown          "#704214")
      )
  "  test keyword face in string  NOTE FIXME TODO"
  ;; test keyword face in comment NOTE FIXME TODO
  (custom-set-faces
   `(font-lock-builtin-face ((t (:foreground ,pink :bold t))) t)
   `(font-lock-comment-face ((t (:foreground ,green))) t)
   `(font-lock-constant-face ((t (:foreground ,gold :bold t))) t)
   `(font-lock-function-name-face
     ((t (:foreground ,white :background ,blue :underline t :bold t))) t)
   `(font-lock-keyword-face ((t (:foreground ,cyan :bold t))) t)
   `(font-lock-string-face ((t (:foreground ,magenta))) t)
   `(font-lock-type-face ((t (:foreground ,pale-green :bold t))) t)
   `(font-lock-variable-name-face ((t (:foreground ,yellow))) t)
   `(font-lock-warning-face
     ((t (:foreground ,black :background ,yellow :bold t))) t)

   `(region ((t (:background "#669933" :distant-foreground "gtk_selection_fg_color"))) t) ;;336633  :distant-foreground "gtk_selection_fg_color" "#ffffff"
   `(org-block ((t (:foreground ,white))) t)
   ;; org-table
   ;; `(org-link ((t (:foreground ,cyan :background nil :bold t))) t)
   ;; `(org-formula ((t (:foreground ,magenta :background ,gray))) t)
   `(highlight ((t (:foreground ,white :background ,blue))) t)
   `(lazy-highlight ((t (:foreground ,white :background ,blue))) t)
   `(isearch
     ((t (:foreground ,black :background ,white :underline t :bold t))) t)
   `(isearch-fail ((t (:background ,red :bold t))) t)
   `(error ((t (:foreground ,red :bold t))) t)
   `(shadow ((t (:foreground ,gray))) t)

   `(popup-face ((t (:foreground ,black :background ,pale))) t)
   `(popup-summary-face ((t (:foreground ,blue :background ,pale))) t)
   `(popup-tip-face ((t (:foreground ,black :background ,blue))) t)
   '(popup-menu-selection-face ((t (:inherit popup-tip-face))) t)
   '(popup-selection-face ((t (:inherit popup-tip-face))) t)
   '(popup-menu-mouse-face ((t (:inherit region))) t)

   '(button ((t (:inherit font-lock-function-name-face))) t)
   '(link ((t (:inherit font-lock-keyword-face :underline t))) t)
   '(link-visited ((t (:inherit font-lock-builtin-face :underline t))) t)
   '(holiday ((t (:inherit button))) t)
   '(diary ((t (:inherit isearch))) t)
   '(minibuffer-prompt ((t (:inherit button))) t)
   '(eshell-prompt ((t (:inherit button))) t)
   '(show-paren-match ((t (:inherit lazy-highlight :bold t))) t)
   '(show-paren-mismatch ((t (:inherit isearch-fail :bold t))) t)
   '(warning ((t (:inherit font-lock-warning-face))) t)
   '(success ((t (:inherit font-lock-type-face))) t)


   ;`(region ((t (:background "#003153"))) t) ;; 其他都好黑色不明显
   ;`(region ((t (:background "#4d3900"))) t) ;; 咖啡, 黑色略淡
   ;`(region ((t (:background "#7b68bb"))) t) ; 绿色略淡
   ;`(region ((t (:background "#996b1f"))) t) ; 可
   ;`(region ((t (:background ,gray))) t)

   `(ediff-current-diff-A ((t (:background "#663333"))) t)
   `(ediff-current-diff-B ((t (:background "#333366"))) t)
   `(ediff-current-diff-C ((t (:background "#336666"))) t)
   `(ediff-current-diff-Ancestor ((t (:background "#666633"))) t)

   `(ediff-fine-diff-A ((t (:background "#880000"))) t)
   `(ediff-fine-diff-B ((t (:background "#000088"))) t)
   `(ediff-fine-diff-C ((t (:background "#008888"))) t)
   `(ediff-fine-diff-Ancestor ((t (:background "#888800"))) t)

   `(ediff-even-diff-A ((t (:background "#442222"))) t)
   `(ediff-even-diff-B ((t (:background "#222244"))) t)
   `(ediff-even-diff-C ((t (:background "#224444"))) t)
   `(ediff-even-diff-Ancestor ((t (:background "#444422"))) t)

   `(ediff-odd-diff-A ((t (:background "#442222"))) t)
   `(ediff-odd-diff-B ((t (:background "#222244"))) t)
   `(ediff-odd-diff-C ((t (:background "#224444"))) t)
   `(ediff-odd-diff-Ancestor ((t (:background "#444422"))) t)
   ))



(provide 'my-theme)
