;;; my-git.el

;; if you want vc-print-log show log with stat, you can specify as following:
;;(setq vc-git-log-switches '("--stat"))

(defun vc-log-file ()
  (interactive)
  (let ((origin vc-git-log-switches))
    (setq vc-git-log-switches '("--stat"))
    (vc-print-log)
    (setq vc-git-log-switches origin)))

  ;;;; using git log seems can not bound buffer to specific file,
  ;;;; may be something setting need to do
  ;; (let* ((filename (buffer-file-name (current-buffer)))
  ;; 	 (buffer (get-buffer-create "*vc-change-log*")))
  ;;   (if filename
  ;; 	(progn
  ;; 	  (shell-command (format "git log --stat %s" filename) buffer)
  ;; 	  (with-current-buffer buffer
  ;; 	    (setq-local vc-log-view-type 'long)
  ;; 	    (vc-git-log-view-mode))))))


;; it seems cannot add --graph (will disable colorful display)
(defun vc-log-root ()
  (interactive)
  (let* ((buffer (get-buffer-create "*vc-change-log*")))
    (shell-command (format "git log --stat" ) buffer)
    (with-current-buffer buffer
      (setq-local vc-log-view-type 'long)
      (vc-git-log-view-mode))))


;; TODO: maybe I can make something like `describe function`'s smartly capture function name, capturing commit id then do something smart

(provide 'my-git)
