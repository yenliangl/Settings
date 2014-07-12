;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yenliangl@gmail.com
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ----------------------------------------------------------------------
;; Basic settings
(load-file (expand-file-name "~/Settings/Emacs/init.el"))

;; ----------------------------------------------------------------------
;; Create two hooks for console and window modes
;; ----------------------------------------------------------------------
(defvar after-make-console-frame-hooks '()
  "Hooks to run after creating a new TTY frame")
(defvar after-make-window-system-frame-hooks '()
  "Hooks to run after creating a new window-system frame")

(defun run-after-make-frame-hooks (frame)
  "Selectively run either `after-make-console-frame-hooks' or
`after-make-window-system-frame-hooks'"
  (select-frame frame)
  (run-hooks (if window-system
                 'after-make-window-system-frame-hooks
               'after-make-console-frame-hooks)))

(add-hook 'after-make-frame-functions 'run-after-make-frame-hooks)
(add-hook 'after-init-hook
          (lambda ()
            (run-after-make-frame-hooks (selected-frame))))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; ----------------------------------------------------------------------
;; Query and search EMACS_HOME
;; ----------------------------------------------------------------------
(add-hook 'isearch-mode-hook
          ;; (function
          (lambda ()
            (define-key isearch-mode-map "\C-h" 'isearch-mode-help)
            (define-key isearch-mode-map "\C-t" 'isearch-toggle-regexp)
            (define-key isearch-mode-map "\C-c" 'isearch-toggle-case-fold)
            (define-key isearch-mode-map "\C-j" 'isearch-edit-string)))
;; Case fold search indicator on mode-line
(add-to-list 'minor-mode-alist '(case-fold-search " CFS"))
(setq-default case-fold-search nil)
(setq search-highlight t
      query-replace-highlight t)


;; ----------------------------------------------------------------------
;; Ido mode: switch to buffers by typing a subset of their names
;; ----------------------------------------------------------------------
(require 'ido)
(ido-mode t)
(setq ido-create-new-buffer 'always)

;; Don't prompt when killing a buffer with a live process attached to it.
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))

;; ----------------------------------------------------------------------
;; Doxygen mode load-path
;; ----------------------------------------------------------------------
(add-to-list 'load-path (concat LISP_HOME "/url"))
(add-to-list 'load-path (concat LISP_HOME "/doxymacs"))
(require 'doxymacs)
(dolist (hook (list 'c++-mode-hook
                    'java-mode-hook))
  (add-hook hook 'doxymacs-font-lock))

;; (defun my-doxymacs-font-lock-hook ()
;;   (when (memq major-mode '(c-mode jde-mode java-mode c++-mode))
;;        (doxymacs-font-lock)))

;; ----------------------------------------------------------------------
;; Emacs goodies
;; ----------------------------------------------------------------------
;; (add-to-list 'load-path (concat LISP_HOME "/emacs-goodies-el"))
;; (require 'emacs-goodies-el)

;; --------------------------------------------------
;; Xrdb mode
;; --------------------------------------------------
;; (autoload 'xrdb-mode "xrdb-mode" "Mode for editing X resource files" t)
;; (setq auto-mode-alist
;;       (append '(("\\.Xdefaults$"    . xrdb-mode)
;;                 ("\\.Xenvironment$" . xrdb-mode)
;;                 ("\\.Xresources$"   . xrdb-mode)
;;                 ("*.\\.ad$"         . xrdb-mode)
;;                 )
;;               auto-mode-alist))

;; ----------------------------------------------------------------------
;; Lex/Yacc/Bison
;; ----------------------------------------------------------------------
(autoload 'make-regexp "make-regexp" "Return a regexp to match a string item in STRINGS." t)
(autoload 'make-regexps "make-regexp"  "Return a regexp to REGEXPS." t)
(autoload 'bison-mode "bison-mode")
(autoload 'flex-mode "flex-mode")
(setq auto-mode-alist
      (append '(("\\.l$" . flex-mode)
                ("\\.y$" . bison-mode)
                )
              auto-mode-alist))

0;; ----------------------------------------------------------------------
;; C/C++
;; ----------------------------------------------------------------------
(load-file (concat EMACS_HOME "/cc.el"))

;; ----------------------------------------------------------------------
;; CEDET
;; ----------------------------------------------------------------------
(and (boundp 'use-jdee) use-jdee
     (progn

       ;; ----------------------------------------------------------------------
       ;; JDEE
       ;; ----------------------------------------------------------------------
       (load-file (concat EMACS_HOME "/jdee.el"))
       ))

(setq compilation-scroll-output t)

;; ----------------------------------------------------------------------
;; emacs-eclim
;; ----------------------------------------------------------------------
;; (add-to-list 'load-path (expand-file-name (concat LISP_HOME "/emacs-eclim")))
;; ;; only add the vendor path when you want to use the libraries provided with emacs-eclim
;; (add-to-list 'load-path (expand-file-name (concat LISP_HOME "/emacs-eclim/vendor")))
;; (require 'eclim)
;; (require 'eclimd)
;; (global-eclim-mode)
;; (setq eclim-auto-save t)

;; (add-to-list 'load-path (expand-file-name (concat LISP_HOME "/company-0.5")))
;; (require 'company)
;; (require 'company-emacs-eclim)
;; (company-emacs-eclim-setup)
;; (global-company-mode t)

;; ----------------------------------------------------------------------
;; ECB
;; ----------------------------------------------------------------------
(and (boundp 'use-ecb) use-ecb
     (load-file (concat EMACS_HOME "/ecb.el"))
     )

;; ----------------------------------------------------------------------
;; Tags/Global
;; ----------------------------------------------------------------------
(autoload 'gtags-mode "gtags" "" t)
(dolist (hook (list 'c-mode-hook
                    'c++-mode-hook
                    'java-mode-hook))
  (add-hook hook '(lambda ()
                    (gtags-mode 1)
                    )))
(add-hook 'gtags-mode-hook
          '(lambda ()
             (setq gtags-pop-delete t)
             (setq gtags-path-style 'absolute)
             (local-set-key (kbd "M-.") 'gtags-find-tag)   ; find a tag, also M-.
             (local-set-key (kbd "M-,") 'gtags-find-rtag)  ; reverse tag
             ))

(add-hook 'gtags-select-mode-hook
          '(lambda ()
             (setq hl-line-face 'underline)
             (hl-line-mode 1)
             ))

;; ----------------------------------------------------------------------
;; _+ Fontlock mode
;; ----------------------------------------------------------------------
;; (add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

(setq font-lock-maximum-decoration t
      keyword-highlight-modes '(java-mode c-mode c++-mode emacs-lisp-mode jde-mode))
(make-face 'font-lock-fixme-face)
(make-face 'font-lock-todo-face)
(make-face 'font-lock-question-face)
(make-face 'font-lock-small-face)
(set-face-attribute 'font-lock-small-face nil :height 0.9)
(mapc (lambda (mode)
        (font-lock-add-keywords
         mode
         '(("\\<\\(FIXME\\):" 1 'font-lock-fixme-face t))))
      keyword-highlight-modes)

(mapc (lambda (mode)
        (font-lock-add-keywords
         mode '(("\\<\\(TODO\\):" 1 'font-lock-todo-face t))))
      keyword-highlight-modes)

(mapc (lambda (mode)
        (font-lock-add-keywords
         mode '(("\\<\\(QUESTION\\)\\?" 1 'font-lock-question-face t))))
      keyword-highlight-modes)

(add-hook 'after-make-window-system-frame-hooks 'josh/set-small-modeline-font-hook)
(defun josh/set-small-modeline-font-hook ()
  "Revert the current buffer without confirmation unless explicitly modified."
  ;; (set-face-attribute 'mode-line nil :height 0.9)
  ;; (set-face-attribute 'mode-line-inactive nil :height 0.9)
  ;; (set-face-attribute 'minibuffer-prompt nil :height 0.9)
  )

;; (add-hook 'after-make-console-frame-hooks 'josh/after-make-console-frame-hook)
;; (defun josh/after-make-console-frame-hook ()
;;   "Revert the current buffer without confirmation unless explicitly modified."
;;   (set-face-attribute 'mode-line nil :height 0.8)
;;   (set-face-attribute 'mode-line-inactive nil :height 0.8)
;;   )

;; ----------------------------------------------------------------------
;; Shell/Multi-term/GUD
;; ----------------------------------------------------------------------
(load-file (concat EMACS_HOME "/shell.el"))

;; ----------------------------------------------------------------------
;; Key mappings.
;; ----------------------------------------------------------------------
(load-file (concat EMACS_HOME "/binding.el"))

;; ----------------------------------------------------------------------
;; Window manager & Moving behavior
;; ----------------------------------------------------------------------
(require 'windmove)
(windmove-default-keybindings 'control)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; _+ Org-mode
;;
(and (boundp 'use-org-mode) use-org-mode
     (progn
       ;; ----------------------------------------------------------------------
       ;; diary
       ;; ----------------------------------------------------------------------
       (setq diary-file (concat user-emacs-directory "/diary"))
       (setq view-diary-entries-initially t
             mark-diary-entries-in-calendar t
             number-of-diary-entries 7)
       (add-hook 'diary-display-hook 'fancy-diary-display)
       (add-hook 'today-visible-calendar-hook 'calendar-mark-today)

       ;; ----------------------------------------------------------------------
       ;; Chinese holidays
       ;; ----------------------------------------------------------------------
       (when (file-exists-p (concat user-emacs-directory "/calendar"))
         (progn
           (require 'cal-china-x)
           (setq mark-holidays-in-calendar t)
           (load-file (concat user-emacs-directory "/calendar"))
           (when (boundp 'cal-china-x-my-lunar-holidays)
             (progn
               (setq cal-china-x-important-holidays cal-china-x-my-lunar-holidays)
               (setq calendar-holidays (append cal-china-x-important-holidays calendar-holidays))))
           ))

       ;; Load org-mode
       (load-file (concat EMACS_HOME "/org.el")))
     )

;; ----------------------------------------------------------------------
;; EasyPG
;;
;; -*- mode: org -*- -*- epa-file-encrypt-to: ("yenliangl@gmail.com") -*-
;; ----------------------------------------------------------------------
(require 'epa)
(epa-file-enable)
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

;; ----------------------------------------------------------------------
;; Uniquify buffer names
;; ----------------------------------------------------------------------
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward
      uniquify-separator ":")

;; ----------------------------------------------------------------------
;; ibuffer
;; ----------------------------------------------------------------------
(require 'ibuffer)
(setq ibuffer-saved-filter-groups
      '(("default"
         ("Org" ;; all org-related buffers
          (mode . org-mode))
         ("Mail"
          (or  ;; mail-related buffers
           (mode . message-mode)
           (mode . mail-mode)
           ;; etc.; all your mail related modes
           ))
         ;; ("Leo21"
         ;;  (or (filename . "/Volumes/Leo21/")
         ;;      (filename . "~/projects/altek/Leo21")))
         ;; ("Froyo"
         ;;  (or (filename . "/Volumes/Froyo/")
         ;;      (filename . "~/projects/android/AndroidSource/Froyo")))
         ;; ("quicklearn-android"
         ;;  (filename . "~/projects/quicklearn-android/"))
         ("Programming" ;; prog stuff not already in MyProjectX
          (or
           (mode . c-mode)
           (mode . perl-mode)
           (mode . python-mode)
           (mode . emacs-lisp-mode)
           (mode . java-mode)
           (mode . jde-mode)
           ;; etc
           ))
	 ("Help" (or (name . "\*Help\*")
		     (name . "\*Apropos\*")
		     (name . "\*info\*")))
         ("ERC" (mode . erc-mode)))))

;; Use human readable Size column instead of original one
(define-ibuffer-column size-h
  (:name "Size" :inline t)
  (cond
   ((> (buffer-size) 1000000) (format "%7.3fM" (/ (buffer-size) 1000000.0)))
   ((> (buffer-size) 1000) (format "%7.3fk" (/ (buffer-size) 1000.0)))
   (t (format "%8d" (buffer-size)))))

;; Modify the default ibuffer-formats
  (setq ibuffer-formats
	'((mark modified read-only " "
		(name 18 18 :left :elide)
		" "
		(size-h 9 -1 :right)
		" "
		(mode 16 16 :left :elide)
		" "
		filename-and-process)))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-auto-mode 1)
            (ibuffer-switch-to-saved-filter-groups "default")))

(setq ibuffer-show-empty-filter-groups nil)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Compare two marked buffers with ediff
(defun ibuffer-ediff-marked-buffers ()
  (interactive)
  (let* ((marked-buffers (ibuffer-get-marked-buffers))
         (len (length marked-buffers)))
    (unless (= 2 len)
      (error (format "%s buffer%s been marked (needs to be 2)"
                     len (if (= len 1) " has" "s have"))))
    (ediff-buffers (car marked-buffers) (cadr marked-buffers))))

(define-key ibuffer-mode-map "e" 'ibuffer-ediff-marked-buffers)

;; ----------------------------------------------------------------------
;; Rainbow delimiters
;; ----------------------------------------------------------------------
;; (when (require 'rainbow-delimiters nil 'noerror)
;;   (progn
;;     (add-hook 'scheme-mode-hook 'rainbow-delimiters-mode)
;;     (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
;;     ))

;; ----------------------------------------------------------------------
;; nav
;;
;; M-x nav
;; ----------------------------------------------------------------------
;; (require 'nav)

;; ----------------------------------------------------------------------
;; Load my secrets
;; ----------------------------------------------------------------------
;; (load-file (concat EMACS_HOME "/secrets.el"))
;; (require 'my-secrets)

;; ----------------------------------------------------------------------
;; Anything
;; ----------------------------------------------------------------------
;; (add-to-list 'load-path (concat LISP_HOME "/elpa/anything-config-0.4.1"))
;; (add-to-list 'load-path (concat LISP_HOME "/elpa/anything-1.287"))
;; (require 'anything-config)

;; (add-to-list 'load-path (concat LISP_HOME "/doremi"))
;; (require 'doremi)
;; (require 'doremi-mac)
;; (require 'doremi-cmd)

;; ----------------------------------------------------------------------
;; magit
;; ----------------------------------------------------------------------
(and (boundp 'use-git-mode) use-git-mode
     (require 'magit))

;; ----------------------------------------------------------------------
;; Resize windows
;; ----------------------------------------------------------------------
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; ----------------------------------------------------------------------
;; bookmark
;; ----------------------------------------------------------------------
(require 'bookmark)
(setq bookmark-default-file (concat user-emacs-directory "/bookmarks")
      bookmark-save-flag 1)
(global-set-key (kbd "<C-f2>") '(lambda () (interactive) (bookmark-set "SAVED")))
(global-set-key (kbd "<C-S-f2>") '(lambda () (interactive) (bookmark-jump "SAVED")))

;; ----------------------------------------------------------------------
;; Emacs/w3m
;; ----------------------------------------------------------------------
(add-to-list 'load-path (concat LISP_HOME "/emacs-w3m/lisp"))
(require 'w3m-load)
;; (setq w3m-command (concat "w3m -bookmark " user-emacs-directory "/.w3m/bookmark.html"))
(defun w3m-browse-url-other-window (url &optional newwin)
  (let ((w3m-pop-up-windows t))
    (if (one-window-p) (split-window))
    (other-window 1)
    (w3m-browse-url url newwin)))
(setq browse-url-browser-function 'w3m-browse-url-other-window
      browse-url-new-window-flag t
      )
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;; optional keyboard short-cut
(global-set-key "\C-xm" 'browse-url-at-point)

(setq w3m-default-display-inline-images t ;show image inline
      w3m-use-cookies t
      w3m-use-tab t                     ;C-cC-t to browse in a new tab
      w3m-coding-system 'utf-8
      w3m-file-coding-system 'utf-8
      w3m-file-name-coding-system 'utf-8
      w3m-input-coding-system 'utf-8
      w3m-output-coding-system 'utf-8
      w3m-terminal-coding-system 'utf-8)

;; ----------------------------------------------------------------------
;; groovy-mode
;; ----------------------------------------------------------------------
;;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
(add-to-list 'load-path (concat LISP_HOME "/Emacs-Groovy-Mode"))
(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'auto-mode-alist '("\.gradle$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

(autoload 'run-groovy "inf-groovy" "Run an inferior Groovy process")
(autoload 'inf-groovy-keys "inf-groovy" "Set local key defs for inf-groovy in groovy-mode")
;;;
(add-hook 'groovy-mode-hook
          '(lambda ()
             (inf-groovy-keys)
             ))

;;; make Groovy mode electric by default.
(add-hook 'groovy-mode-hook
          '(lambda ()
             (require 'groovy-electric)
             (groovy-electric-mode)))

;; ----------------------------------------------------------------------
;; Twittering mode
;; ----------------------------------------------------------------------
;; (when window-system
;;   (add-to-list 'load-path (concat LISP_HOME "/twittering-mode/head"))
;;   (require 'twittering-mode)
;;   )

;;
;; compare and diff two directories
;;
;; (require 'dircmp-mode)
;; (load (concat ELPA_HOME "/dircmp-1/dircmp.el"))

;; ----------------------------------------------------------------------
;; GUI config
;; ----------------------------------------------------------------------
(when window-system
  (progn
    (setq default-frame-alist
          '((vertical-scroll-bars)
            ;(alpha 95 90)                   ;transparency
            (left-fringe . 2)
            (right-fringe . 2)
            ))

    ;; --------------------------------------------------
    ;; Hideshow
    ;; --------------------------------------------------
    (add-to-list 'load-path (concat LISP_HOME "/elpa/hideshowvis-0.3"))
    (autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
    (autoload 'hideshowvis-minor-mode
      "hideshowvis"
      "Will indicate regions foldable with hideshow in the fringe."
      'interactive)

    (dolist (hook (list 'emacs-lisp-mode-hook
                        'c++-mode-hook
                        'java-mode-hook))
      (add-hook hook 'hideshowvis-enable))

    ;; --------------------------------------------------
    ;; elscreen
    ;; --------------------------------------------------
    (load-file (concat EMACS_HOME "/elscreen.el"))

    ))


(and (boundp 'use-org-mode) use-org-mode
     (appt-activate t))
