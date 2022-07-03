;;; my-kuma.el -*- lexical-binding: t -*-

(defvar web-open-command
  (cond ((string= system-type "gnu/linux") "xdg-open")
	((string= system-type "darwin") "open")
	((string= system-type "windows-nt") "call") ;; TODO: try
	(t nil)))

;; TODO: change doc from nightly to stable, but there is some issue for m1
;; https://github.com/rust-lang/rustup/issues/2692
(defun rust-search-std-locally ()
  (interactive)
  (call-process-shell-command
   (format "osascript -e 'tell application \"safari\" to open location \"file:///Users/wufangjie/.rustup/toolchains/nightly-aarch64-apple-darwin/share/doc/rust/html/std/index.html?search=%s\"'"
	   (read-from-minibuffer "Keyword: "))
   nil 0)
  (call-process-shell-command "open -a safari" nil 0)
  )

(global-set-key (kbd "C-'") 'rust-search-std-locally)


(let ((pairs
       '(("bing" . "https://www.bing.com/search?q=%s")
	 ("dict(bing)" . "https://cn.bing.com/dict/search?q=%s")
	 ("google" . "https://www.google.com/search?q=%s")
	 ("scholar(google)" . "https://scholar.google.com/scholar?q=%s")
	 ("stackoverflow" . "https://stackoverflow.com/search?q=%s")
	 ("wiki" . "https://en.wikipedia.org/wiki/%s")
	 ("douban" . "https://www.douban.com/search?q=%s")
	 ("book(douban)" . "https://book.douban.com/subject_search?search_text=%s&cat=1001")
	 ("movie(douban)" . "https://movie.douban.com/subject_search?search_text=%s&cat=1002")
	 ("github" . "https://github.com/search?q=%s")
	 ("jingdong" . "https://search.jd.com/Search?keyword=%s&enc=utf-8")
	 ("taobao" . "https://s.taobao.com/search?q=%s")
	 ("zhihu" . "https://www.zhihu.com/search?type=content&q=%s")
	 ("baidu" . "https://www.baidu.com/s?wd=%s")
	 ("pythonlibs" . "https://www.lfd.uci.edu/~gohlke/pythonlibs/")
	 ("pypi" . "https://pypi.python.org/search/?q=%s")
	 )))
  (let ((dict (make-hash-table :test 'equal)))
    (dolist (pair pairs)
      (puthash (car pair) (cdr pair) dict))
    (defun kuma ()
      (interactive)
      (let ((content (gethash (completing-read "Search (web): " dict) dict)))
	(if content
	    (if web-open-command
		(call-process-shell-command
		 (format "%s \"%s\""
			 web-open-command
			 ;; TODO: urlencode
			 (format content (read-from-minibuffer "Keyword: ")))
		 nil 0)
	      (message "Unknown system!"))
	  (message "Unknown type!"))
	))))


(global-set-key (kbd "C-;") 'kuma)


(provide 'my-kuma)
