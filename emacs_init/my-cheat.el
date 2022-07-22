;;; my-cheat.el

;; An emacs wrapper to interact with cheat.sh

;; 设计思路大致是:
;; 命令如果以 / 开头, 则重置所有搜索（包括当前主题）
;; 直接输数字，表示最后搜索的问题加翻页
;; 其他情况（默认情况，最常用，即直接搜索）（如果当前只有主题则在主题下搜索）继续搜索
;; 支持空格（最终是转化成 http，所以空格是可以的）
;; 根据主题打开对应 buffer 并设置 major mode
;; 保存历史记录 主题+问题 TODO: 保存成文件
;; Prefix + 数字前缀 表示默认前几条命令
;; TODO: 想个快捷键
;; TODO: 有点慢，如何加速


;; `global-variable`
(defvar cheat-topic nil)
(defvar cheat-history '())
(defvar cheat-page 1)


;; `mode-specific`
(defun cheat-get-buffer ()
  (cond ((string= cheat-topic "rust") "*cheat-rust*")
	((string= cheat-topic "elisp") "*cheat-elisp*")
	((string= cheat-topic "python") "*cheat-python*")
	(t "*cheat-sh*")))

(defun cheat-sh-mode-setup ()
  "Set up the cheat mode for the current buffer."
  (cond ((string= cheat-topic "rust") (rust-mode))
	((string= cheat-topic "elisp") (emacs-lisp-mode))
	((string= cheat-topic "python") (python-mode))
	(t (sh-mode)))
  (setq buffer-read-only nil))


;; main function
(defun cht-sh (i) ;; with last i query as default content
  ;; if no prefix is given, arg == 1, so do not use C-1 to prefix
  (interactive "p")
  (let* ((prompt (if cheat-topic
		     (format "cht.sh/%s%s> "
			     cheat-topic
			     (if (< cheat-page 2) "" (format "/.../%d" cheat-page)))
		   "cht.sh> "))
	 (default (if (= 1 i) "" (nth (max (- (abs i) 1) 0) cheat-history))))
    (cheat-run (read-from-minibuffer prompt default)))
  )


;; dispatch command
;; only record /topic/query (without /page)
(defun cheat-run (thing)
  (let ((thing (string-trim thing)))
    (cond ((string-match "^/" thing)  ;; reset topic, then search
	   (let ((lst (split-string thing "/" t)))
	     (setq cheat-topic (car lst))
	     (when (cadr lst)
	       (cheat-sh thing)
	       (cheat-record thing))))
	  ((string-match "^[0-9]+$" thing)  ;; specific page
	   (let ((last (car cheat-history)))
	     (when last
	       (cheat-sh (format "%s/%s" last thing)))))
	  ((string-match "^[[-]$" thing)  ;; previous page
	   (let ((last (car cheat-history)))
	     (when last
	       (when (> cheat-page 1)
		 (setq cheat-page (1- cheat-page))
		 (cheat-sh (format "%s/%d" last cheat-page))))))
	  ((string-match "^[]+]$" thing)  ;; next page
	   (let ((last (car cheat-history)))
	     (when last
	       (setq cheat-page (1+ cheat-page))
	       (cheat-sh (format "%s/%d" last cheat-page)))))
	  (t  ;; search under current topic
	   (if cheat-topic
	       (let ((thing (format "/%s/%s" cheat-topic thing)))
		 (cheat-sh thing)
		 (cheat-record thing))))
	  )))


;; record history and reset page if necessary
(defun cheat-record (thing)
  (let ((query-no-page (replace-regexp-in-string "/[0-9]+$" "" thing)))
    (unless (string= (car cheat-history) query-no-page)
      (setq cheat-history (cons query-no-page cheat-history)))
    (setq cheat-page (if (string-match "/[0-9]+$" thing)
			 (string-to-number (match-string 0 thing))
		       1))
    ))


;;; forked following from cheat.el
;;; modified unique buffer to topic specific buffers

(defconst cheat-sh-url "http://cheat.sh/%s?T"
  "URL for cheat.sh.")

(defconst cheat-sh-user-agent "cheat-sh.el (curl)"
  "User agent to send to cheat.sh.
Note that \"curl\" should ideally be included in the user agent
string because of the way cheat.sh works.
cheat.sh looks for a specific set of clients in the user
agent (see https://goo.gl/8gh95X for this) to decide if it should
deliver plain text rather than HTML. cheat-sh.el requires plain
text.")

(defun cheat-sh-get (thing)
  "Get THING from cheat.sh."
  (let* ((url-request-extra-headers `(("User-Agent" . ,cheat-sh-user-agent)))
         (buffer (url-retrieve-synchronously (format cheat-sh-url (url-hexify-string thing)) t t)))
    (when buffer
      (unwind-protect
          (with-current-buffer buffer
            (set-buffer-multibyte t)
            (setf (point) (point-min))
            (when (search-forward-regexp "^$" nil t)
              (buffer-substring (1+ (point)) (point-max))))
        (kill-buffer buffer)))))

(defun cheat-sh (thing)
  "Look up THING on cheat.sh and display the result."
  (let ((result (cheat-sh-get thing)))
    (if result
        (let ((temp-buffer-window-setup-hook
               (cons 'cheat-sh-mode-setup temp-buffer-window-show-hook)))
          (with-temp-buffer-window (cheat-get-buffer) nil 'help-window-setup
            (princ result)))
      (error "Can't find anything for %s on cheat.sh" thing))))

(provide 'my-cheat)
