;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/wfj/emacs_init")

;; (setq lexical-binding t)

;; TODO: use use-package to defer load? It seems no need

;;(global-unset-key (kbd "M-SPC"))

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

;; (require 'package)
;; (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
;;                     (not (gnutls-available-p))))
;;        (proto (if no-ssl "http" "https")))
;;   (setq package-archives
;; 	(list (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")))))
;; (package-initialize)

;; (require 'pyim)
;; (require 'pyim-basedict)
;; (pyim-basedict-enable)
;; (setq default-input-method "pyim")
;; (setq pyim-page-length 9)

;; (global-unset-key (kbd "M-SPC"))
;; (global-set-key (kbd "M-SPC") 'toggle-input-method)
;; (global-unset-key (kbd "C-\\"))
;; ;; (global-set-key (kbd ("C-\\" . pyim-convert-string-at-point)))

;; ;; (setq pyim-punctuation-translate-p '(no yes auto)) ;; useless?
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (company flycheck lsp-mode gnu-elpa-keyring-update rustic use-package js2-mode jedi)))
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
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(button ((t (:inherit font-lock-function-name-face))))
 '(diary ((t (:inherit isearch))))
 '(ediff-current-diff-A ((t (:background "#663333"))) t)
 '(ediff-current-diff-Ancestor ((t (:background "#666633"))) t)
 '(ediff-current-diff-B ((t (:background "#333366"))) t)
 '(ediff-current-diff-C ((t (:background "#336666"))) t)
 '(ediff-even-diff-A ((t (:background "#442222"))) t)
 '(ediff-even-diff-Ancestor ((t (:background "#444422"))) t)
 '(ediff-even-diff-B ((t (:background "#222244"))) t)
 '(ediff-even-diff-C ((t (:background "#224444"))) t)
 '(ediff-fine-diff-A ((t (:background "#880000"))) t)
 '(ediff-fine-diff-Ancestor ((t (:background "#888800"))) t)
 '(ediff-fine-diff-B ((t (:background "#000088"))) t)
 '(ediff-fine-diff-C ((t (:background "#008888"))) t)
 '(ediff-odd-diff-A ((t (:background "#442222"))) t)
 '(ediff-odd-diff-Ancestor ((t (:background "#444422"))) t)
 '(ediff-odd-diff-B ((t (:background "#222244"))) t)
 '(ediff-odd-diff-C ((t (:background "#224444"))) t)
 '(error ((t (:foreground "#e31b1c" :bold t))))
 '(eshell-prompt ((t (:inherit button))))
 '(font-lock-builtin-face ((t (:foreground "#ffbbff" :bold t))))
 '(font-lock-comment-face ((t (:foreground "#66cd00"))))
 '(font-lock-constant-face ((t (:foreground "#ffb90f" :bold t))))
 '(font-lock-function-name-face ((t (:foreground "#ffffff" :background "#4682b4" :underline t :bold t))))
 '(font-lock-keyword-face ((t (:foreground "#00ffff" :bold t))))
 '(font-lock-string-face ((t (:foreground "#ffa07a"))))
 '(font-lock-type-face ((t (:foreground "#9aff9a" :bold t))))
 '(font-lock-variable-name-face ((t (:foreground "#ffec8b"))))
 '(font-lock-warning-face ((t (:foreground "#000000" :background "#ffec8b" :bold t))))
 '(highlight ((t (:foreground "#ffffff" :background "#4682b4"))))
 '(holiday ((t (:inherit button))))
 '(isearch ((t (:foreground "#000000" :background "#ffffff" :underline t :bold t))))
 '(isearch-fail ((t (:background "#e31b1c" :bold t))))
 '(lazy-highlight ((t (:foreground "#ffffff" :background "#4682b4"))))
 '(link ((t (:inherit font-lock-keyword-face :underline t))))
 '(link-visited ((t (:inherit font-lock-builtin-face :underline t))))
 '(minibuffer-prompt ((t (:inherit button))))
 '(org-block ((t (:foreground "#ffffff"))))
 '(popup-face ((t (:foreground "#000000" :background "#d3d3d3"))) t)
 '(popup-menu-mouse-face ((t (:inherit region))) t)
 '(popup-menu-selection-face ((t (:inherit popup-tip-face))) t)
 '(popup-selection-face ((t (:inherit popup-tip-face))) t)
 '(popup-summary-face ((t (:foreground "#4682b4" :background "#d3d3d3"))) t)
 '(popup-tip-face ((t (:foreground "#000000" :background "#4682b4"))) t)
 '(region ((t (:background "#669933" :distant-foreground "gtk_selection_fg_color"))))
 '(shadow ((t (:foreground "#625b57"))))
 '(show-paren-match ((t (:inherit lazy-highlight :bold t))))
 '(show-paren-mismatch ((t (:inherit isearch-fail :bold t))))
 '(success ((t (:inherit font-lock-type-face))))
 '(warning ((t (:inherit font-lock-warning-face)))))
