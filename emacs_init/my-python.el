;;; my-python.el -*- lexical-binding: t -*-

;; #####################################################################
;; `python'
;; hide / show code, M-x hs-<TAB>
;; #####################################################################
(setq python-shell-completion-native-enable nil)

(if (string-equal system-type "gnu/linux")
    (setq python-shell-interpreter "python3"))

;; (add-hook 'python-mode-hook 'hs-minor-mode)
(add-hook 'inferior-python-mode-hook
	  (lambda ()
	    ;; (outline-minor-mode t)
	    ;; (setq outline-regexp "\\(>>> \\)+")
	    (setq-local paragraph-start "^>>> ")
	    ;; (paragraph-separate "")
	    ;; (setq comint-use-prompt-regexp t)
	    ;; (setq comint-prompt-regexp "^\\(>>> \\)+"
	    ))


(generate-easy-insert-func
 "python"
 `(("head" . "#!/usr/bin/python3\n# -*- coding: utf-8 -*-\n\n")
   ("main" . "if __name__ == '__main__':\n    ")
   ("path" . ,(concat
	       "import os\n\n\ntry:\n"
	       "    path = os.path.split(os.path.realpath(__file__))[0]\n"
	       "except NameError:\n"
	       "    path = os.getcwd() or os.getenv('PWD')\n\n"))
   ("pdb"  . "import pdb; pdb.set_trace()\n")))



;; #####################################################################
;; `jedi'
;; #####################################################################
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))


;; (add-to-list 'load-path "~/.emacs.d/el-get/el-get")
;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;     (goto-char (point-max))
;;     (eval-print-last-sexp)))
;; (el-get 'sync)

;; (setq jedi:server-args
;;       '("--sys-path" "/usr/local/lib/python3.8/dist-packages"
;; 	"--sys-path" "/usr/lib/python3/dist-packages"
;; 	"--sys-path" "/usr/lib/python3.8/dist-packages"
;; 	;"--sys-path" "~/packages"
;; 	))

(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'flycheck-mode)

;; NOTE: Do not add jedi to interpreter, pdb single character complete!
;; (add-hook 'inferior-python-mode-hook 'jedi:setup)



(provide 'my-python)
