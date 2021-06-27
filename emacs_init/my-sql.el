;;; my-sql.el -*- lexical-binding: t -*-

(require 'my-utils)

(setq sql-mysql-options '("-A" "-C" "-t" "-f" "-n"))
(setq sql-user "wufj")
;; (setq sql-password "MTvaoc2ouUwQJ9vr")
;; (setq sql-server "101.132.176.239")
(setq sql-password "XSp9mA6i7DMybooC")
(setq sql-server "47.114.155.25")
(setq sql-database "miulee4")


(add-hook 'sql-interactive-mode-hook
	  (lambda ()
	    (setq truncate-lines t)))


(generate-easy-insert-func
 "sql"
 `(("select" . "select *\nfrom \nwhere 1\nlimit 0,1;")
   ("insert" . "insert into \n()\nvalue ();")
   ("update" . "update \nset \nwhere ;")
   ("delete" . "delete from \nwhere 0;")))

;; (let* ((pairs `(("select" . "select *\nfrom \nwhere 1\nlimit 0, 1;")
;; 		("insert" . "insert into \n()\nvalue ();")
;; 		("update" . "update \nset \nwhere ;")
;; 		("delete" . "delete from \nwhere 0;")))
;;        (func (make-insert-func-from-pairs pairs)))
;;   (defun insert-mysql-template ()
;;     (interactive)
;;     (funcall func)))

;; (setq mysql-template #s(hash-table test equal))
;; (dolist
;;     (pair
;;      `(("select" . "select *\nfrom \nwhere 1\nlimit 0, 1;")
;;        ("insert" . "insert into \n()\nvalue ();")
;;        ("update" . "update \nset \nwhere ;")
;;        ("delete" . "delete from \nwhere 0;")))
;;   (puthash (car pair) (cdr pair) mysql-template))


;; (defun insert-mysql-template ()
;;   (interactive)
;;   (let* ((type (completing-read "mysql type: " mysql-template))
;; 	 (content (gethash type mysql-template "")))
;;     (princ content (current-buffer))))

(provide 'my-sql)
