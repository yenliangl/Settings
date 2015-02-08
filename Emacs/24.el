;; ------------------------------------------------------------
;; Stuff that is specific to Emacs 24
;; ------------------------------------------------------------

;; --------------------------------------------------
;; package sources
;; --------------------------------------------------
;(require 'package)
(setq package-enable-at-startup nil)
(package-initialize)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
;;(add-to-list 'package-archives '("elpa" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

;; --------------------------------------------------
;; Color theme
;; --------------------------------------------------
(add-to-list 'custom-theme-load-path (concat ELPA_HOME "/github-theme-0.0.3"))
(add-to-list 'custom-theme-load-path (concat ELPA_HOME "/django-theme-1.0.2"))
(add-to-list 'custom-theme-load-path (concat ELPA_HOME "/ujelly-theme-1.0.6"))
(add-hook 'after-make-window-system-frame-hooks
          (lambda ()
            ;; (load-theme 'firecode)
            (load-theme 'flatland-black)
            ))
;; (autoload 'color-theme-approximate-on "color-theme-approximate")
;; (color-theme-approximate-on)

;; --------------------------------------------------
;; Org-mode
;; --------------------------------------------------
(setq ORG_LISP_HOME (concat LISP_HOME "/org/main"))
(add-to-list 'load-path (concat ORG_LISP_HOME "/lisp"))
(add-to-list 'load-path (concat ORG_LISP_HOME "/contrib/lisp"))
