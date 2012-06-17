;; ------------------------------------------------------------
;; Stuff that is specific to Emacs 24
;; ------------------------------------------------------------

;; --------------------------------------------------
;; package sources
;; --------------------------------------------------
(require 'package)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
;; Add the user-contributed repository
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

;; --------------------------------------------------
;; Color theme
;; --------------------------------------------------
(add-to-list 'custom-theme-load-path (concat user-emacs-directory "/themes/24"))
(add-hook 'after-make-window-system-frame-hooks
          (lambda ()
            ;; (load-theme 'tango-dark)
            (load-theme 'monokai)
            ))

;; --------------------------------------------------
;; Org-mode
;; --------------------------------------------------
(setq ORG_LISP_HOME (concat LISP_HOME "/org/org-7.8.09"))
(add-to-list 'load-path (concat ORG_LISP_HOME "/lisp"))
(add-to-list 'load-path (concat ORG_LISP_HOME "/contrib/lisp"))
