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
(add-to-list 'custom-theme-load-path (concat ELPA_HOME "/github-theme-0.0.3"))
(add-to-list 'custom-theme-load-path (concat ELPA_HOME "/django-theme-1.0.2"))
(add-to-list 'custom-theme-load-path (concat ELPA_HOME "/ujelly-theme-1.0.6"))
(add-hook 'after-make-window-system-frame-hooks
          (lambda ()
            ;; (load-theme 'twilight)
            (load-theme 'monokai)
            ;; (load-theme 'zen-and-art)
            ))

;; --------------------------------------------------
;; Org-mode
;; --------------------------------------------------
(setq ORG_LISP_HOME (concat LISP_HOME "/org/org-7.9.2"))
(add-to-list 'load-path (concat ORG_LISP_HOME "/lisp"))
(add-to-list 'load-path (concat ORG_LISP_HOME "/contrib/lisp"))
