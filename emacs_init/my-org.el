;;; my-org.el -*- lexical-binding: t -*-



(setq org-emphasis-regexp-components
      '("- 	('\"{【　"
	"- 	.,:!?;'\")}\\[】"
	" 	
"
	"."
	1))


;; #####################################################################
;; `org-mode'
;; #####################################################################

(add-hook 'org-mode-hook
	  (lambda ()
	    ;(linum-mode -1)
	    (setq truncate-lines nil) ; use M-x toggle-truncate-lines
	    ;(setq org-src-fontify-natively t)  ; highlight source code
	    (setq org-html-validation-link nil)
	    ;; (setcar org-emphasis-regexp-components "- 	('\"{【　")
	    ;; (setcar (cdr org-emphasis-regexp-components) "- 	.,:!?;'\")}\\[】")
	    ;; (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
	    ))


(generate-easy-insert-func
 "org-head"
 `(("basic" . ,(concat
		"#+AUTHOR: wfj\n"
		"#+EMAIL: wufangjie1223@126.com\n"
		"#+OPTIONS: ^:{} \\n:t email:t\n"))

   ("html" . ,(concat
	       "#+HTML_HEAD_EXTRA: <style type=\"text/css\"> body {padding-left: 26%; background: #e3edcd;} #table-of-contents {position: fixed; width: 25%; height: 100%; top: 0; left: 0; overflow-y: scroll; resize: horizontal;} i {color: #666666;} pre, pre.src:before {color: #ffffff; background: #131926;} </style>\n"
	       "#+HTML_HEAD_EXTRA: <script type=\"text/javascript\"> function adjust_html(){document.getElementsByTagName(\"body\")[0].style.cssText=\"padding-left: \"+(parseInt(document.getElementById(\"table-of-contents\").style.width)+5)+\"px; background: #e3edcd;\"}; window.onload=function (){document.getElementById(\"table-of-contents\").addEventListener(\"mouseup\",adjust_html,true)}</script>\n"))

   ("slide" . ,(concat
		"#+OPTIONS: H:2 toc:t num:t\n"
		"#+LATEX_HEADER: \\usepackage{xeCJK}\n"
		"#+LATEX_COMPILER: xelatex\n"
		"#+LATEX_CLASS: beamer\n"
		"#+LATEX_CLASS_OPTIONS: [presentation]\n"
		"#+BEAMER_THEME: Madrid\n"
		"#+COLUMNS: %45ITEM %10BEAMER_ENV(Env) %10BEAMER_ACT(Act) %4BEAMER_COL(Col)\n"))

   ("math" . ,(concat
	       "#+HTML_HEAD_EXTRA: <style type=\"text/css\"> mjx-mspace {white-space: normal;} </style>\n" ; have forgotton why
	       "#+HTML_MATHJAX: path: \"https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js\"\n"
	       ))
   ))

; https://1024th.github.io/MathJax_Tutorial_CN/#/document

(setq org-html-mathjax-template
      "
<script type=\"text/x-mathjax-config\">
    MathJax.Hub.Config({
        displayAlign: \"%ALIGN\",
        displayIndent: \"%INDENT\",

        extensions: [\"tex2jax.js\"],
        jax: [\"input/TeX\",\"output/HTML-CSS\"],
        tex2jax: {inlineMath: [[\"$\",\"$\"],[\"\\\\(\",\"\\\\)\"]]}
});
</script>
<script type=\"text/javascript\" src=\"%PATH\"></script>
")

(provide 'my-org)
