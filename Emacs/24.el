;; ------------------------------------------------------------
;; Stuff that is specific to Emacs 24
;; ------------------------------------------------------------

;; --------------------------------------------------
;; package sources
;; --------------------------------------------------
;(require 'package)
(setq package-enable-at-startup nil)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; --------------------------------------------------
;; Color theme
;; --------------------------------------------------
(add-hook 'after-make-window-system-frame-hooks
          (lambda ()
            ;; (load-theme 'firecode)
            ;; (load-theme 'ample-zen)
            (load-theme 'jbeans)
            ;; (load-theme 'twilight)
            (set-face-background 'default "black")
            ))
(add-hook 'after-make-console-frame-hooks
          (lambda ()
            (load-theme 'jbeans)
            ;; (load-theme 'ample-zen)
            ;; (load-theme 'atom-one-dark)
            ;; (load-theme 'twilight)

            ;; I like the color but the background
            ;;(load-theme 'twilight)
            (set-face-background 'default "black")
            ))
;; (autoload 'color-theme-approximate-on "color-theme-approximate")
;; (color-theme-approximate-on)

;; for TERM=xterm
;;(set-face-foreground 'minibuffer-prompt "red")

;; --------------------------------------------------
;; Org-mode
;; --------------------------------------------------
(setq ORG_LISP_HOME (concat LISP_HOME "/org/main"))
(add-to-list 'load-path (concat ORG_LISP_HOME "/lisp"))
(add-to-list 'load-path (concat ORG_LISP_HOME "/contrib/lisp"))
