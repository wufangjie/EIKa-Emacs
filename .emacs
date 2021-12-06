;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/EIKa-Emacs/emacs_init")

;; (setq lexical-binding t)
;; TODO: use use-package to defer load? It seems no need

(require 'my-theme)
(require 'my-basic)
(require 'my-utils)

(require 'my-shell)

(require 'my-file)
(require 'my-org)

(require 'my-rust)
;(require 'my-cc)
(require 'my-sql)
(require 'my-python)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (htmlize company flycheck lsp-mode gnu-elpa-keyring-update rustic use-package js2-mode jedi)))
 '(safe-local-variable-values
   (quote
    ((eval ignore-errors "Write-contents-functions is a buffer-local alternative to before-save-hook"
	   (add-hook
	    (quote write-contents-functions)
	    (lambda nil
	      (delete-trailing-whitespace)
	      nil))
	   (require
	    (quote whitespace))
	   "Sometimes the mode needs to be toggled off and on."
	   (whitespace-mode 0)
	   (whitespace-mode 1))
     (whitespace-line-column . 80)
     (whitespace-style face tabs trailing lines-tail)))))

;; #####################################################################
;; `color'
;; useful functions: list-color-display list-faces-display describe-face
;; #####################################################################
(let ((white          "#ffffff")
      (black          "#000000") ; 131926
      (gray           "#625b57") ; 555753 666666
      (red            "#e31b1c")
      (green          "#66cd00")
      (pale-green     "#9aff9a")
      (yellow         "#ffec8b")
      (gold           "#ffb90f")
      (blue           "#4682b4")
      (magenta        "#ffa07a") ; ff9969 ff9900
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

   `(region ((t (:background "#669933" :distant-foreground "gtk_selection_fg_color"))) t)
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
