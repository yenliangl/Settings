;; ------------------------------------------------------------
;; Stuff that is specific to Emacs 24
;; ------------------------------------------------------------
(message "===> loading settings for Emacs 24")

;; --------------------------------------------------
;; package sources
;; --------------------------------------------------
(require 'package)
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
;; Add the user-contributed repository
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

;; --------------------------------------------------
;; Color theme
;; --------------------------------------------------
(add-hook 'after-make-window-system-frame-hooks
          (lambda ()
            (load-theme 'tango-dark)
            ))

;; --------------------------------------------------
;; Org-mode
;; --------------------------------------------------
(setq ORG_LISP_HOME (concat LISP_HOME "/org/org-7.8.09"))

;; (add-to-list load-path (concat LISP_HOME "/remember"))
(add-to-list 'load-path (concat ORG_LISP_HOME "/lisp"))
(add-to-list 'load-path (concat ORG_LISP_HOME "/contrib/lisp"))
