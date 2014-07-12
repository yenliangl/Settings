;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;+ JDEE settings
;;
(setq JDE_LISP_HOME (concat LISP_HOME "/jde/2.4.0.1"))
;; (setq debug-on-error nil)
(add-to-list 'load-path (concat JDE_LISP_HOME "/lisp"))
(add-to-list 'load-path (concat LISP_HOME "/elib-1.0"))

(require 'jde)

;; (setq defer-loading-jde t)
;; (if defer-loading-jde
;;     (progn
;;       (autoload 'jde-mode "jde" "JDE mode." t)
;;       (setq auto-mode-alist
;;             (append
;;              '(("\\.java$" . jde-mode))
;;              auto-mode-alist)))
;;   (require 'jde))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;+ JDEE prj.el template
;;
(defun add_classpath (classpath)
  (cond
   ((stringp classpath)
    (add-to-list 'jde-global-classpath classpath))
   ((listp classpath)
    (setq jde-global-classpath (append jde-global-classpath classpath)))
   ))

(defun add_src_path (src_path)
  (cond
   ((stringp src_path)
    (add-to-list 'jde-sourcepath src_path))
   ((listp src_path)
    (setq jde-sourcepath (append jde-sourcepath src_path)))
   ))

;; progname
;;   -
;;    | src
;;    | test
;;    | bin
;;    | lib


;;;elisp 的一点语法
;;;   '("aaa" "bbb" "ccc" )  与(quote ("aaa" "bbb" "ccc"))同
;;;   将 "aaa" 变成 '(aaa)  使用 (list "aaa")     '("aaa" "bbb" ) 变成 '("aaa" "bbb" "ccc")的语法 (append  _listname  string    );;;    (setq var value)  与 '(var value) 同为设值

;;在编辑java 文件时 Ctrl+return 代码提示
;; (defun my-java-jde-mode-hook()
;;   (local-set-key (quote [C-return]) (quote jde-complete));;java jde 自动补全键C-return
;;     )
;; (add-hook 'java-mode-hook 'my-java-jde-mode-hook)
