;; Paths
(unless (boundp 'EMACS_HOME)
	(defconst EMACS_HOME (expand-file-name "~/Settings/Emacs")))

(unless (boundp 'DROPBOX)
        (defconst DROPBOX (expand-file-name "~/Dropbox")))
(setq user-emacs-directory (concat DROPBOX "/.emacs.d"))
(defconst LISP_HOME (expand-file-name (concat user-emacs-directory "/elisp")))
(defconst ELPA_HOME (expand-file-name (concat user-emacs-directory "/elpa")))
(add-to-list 'load-path LISP_HOME)

;;(require 'cask "/usr/local/Cellar/cask/0.7.2_1/cask.el")
;;(cask-initialize)
;;(require 'pallet)
;;(pallet-mode t)

;; ----------------------------------------------------------------------
;; Basic settings
;; ----------------------------------------------------------------------
;; (mouse-wheel-mode 1)

;; Language environment
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8-unix)
(setenv "TERM" "emacs")

(setq default-major-mode 'text-mode
      inhibit-startup-messages t
      require-final-newline t
      next-line-add-newlines nil
      show-paren-style 'paren
      find-file-existing-other-name t ; Make emacs recognize that symlinks are the same files
      debug-on-error nil
      scroll-margin 3
      oll-conservatively 10000
      visible-bell nil
      x-select-enable-clipboard t       ;already t in Emacs 24.
      column-number-mode t

      ;; --------------------------------------------------
      ;; Backup
      ;; --------------------------------------------------
      auto-save-directory (expand-file-name "~/.emacs-saves/")
      auto-save-default t
      auto-save-directory-fallback auto-save-directory
      auto-save-hash-p nil
      efs-auto-save t
      efs-auto-save-remotely nil
      ;; now that we have auto-save-timeout, let's crank this up
      ;; for better interactive response.
      auto-save-interval 800

      backup-directory-alist '(("." . "~/.backup"))
      kept-new-versions 16
      kept-old-versions 2
      delete-old-versions t
      backup-by-copying-when-linked t

      ;; --------------------------------------------------
      ;; Version control
      ;; --------------------------------------------------
      version-control t
      vc-handled-backends nil           ;speed-up saving buffers
      vc-make-backup-files nil
      vc-cvs-stay-local nil             ; automatic version backup.

      ;; --------------------------------------------------
      ;; Auto-revert buffer when disk file changes
      ;; --------------------------------------------------
      auto-revert-interval 3
      auto-revert-check-vc-info t

      tramp-default-method "ssh"        ;smb

      )

(fset 'yes-or-no-p 'y-or-n-p)
(setq-default fill-column 80
              indent-tabs-mode nil
              line-number-mode t
              column-number-mode t
              transient-mark-mode t     ; Transient mark mode
              cursor-type 'box
              )

(global-auto-revert-mode t)
(global-font-lock-mode t)
(show-paren-mode t)                     ; Parenesis mode
(blink-cursor-mode 0)
(when window-system
  (tool-bar-mode -1))
(menu-bar-mode -1)

;; --------------------------------------------------
;; handle trailing whitespaces
;; --------------------------------------------------
(setq-default show-trailing-whitespace t)
(setq default-indicate-empty-lines t)

;; --------------------------------------------------
;; system-specific
;; --------------------------------------------------
;; work around a bug on OS X where system-name is FQDN
(if (eq system-type 'darwin)
    (setq system-name (car (split-string system-name "\\."))))

;; keep system- or user-specific customizations here
(setq system-specific-config (concat EMACS_HOME "/" system-name ".el")
      user-specific-config (concat EMACS_HOME "/" user-login-name ".el")
      user-specific-dir (concat EMACS_HOME "/" user-login-name))
(add-to-list 'load-path user-specific-dir)

(if (file-exists-p system-specific-config) (load system-specific-config))
(if (file-exists-p user-specific-config) (load user-specific-config))
(if (file-exists-p user-specific-dir)
    (mapc #'load (directory-files user-specific-dir nil ".*el$")))

(setq version-specific-config (concat EMACS_HOME "/" (number-to-string emacs-major-version) ".el"))
(if (file-exists-p version-specific-config) (load version-specific-config))

;; (defconst is-after-emacs-23  (<= 23 emacs-major-version))
;; (defconst is-after-emacs-24  (<= 24 emacs-major-version))

;;
(setq user-full-name "Liu Yen-Liang (Josh)")
(setq user-mail-address "yenliangl@gmail.com")

;; ----------------------------------------------------------------------
;; CEDET
;; ----------------------------------------------------------------------
(and (boundp 'use-cedet) use-cedet
     (progn
       ;; ----------------------------------------------------------------------
       ;; CEDET
       ;; ----------------------------------------------------------------------
       (load-file (concat EMACS_HOME "/cedet.el"))
       ))

(setq compilation-scroll-output t)

;; remove
;; (remove-hook 'before-save-hook 'delete-trailing-whitespace)

;; ----------------------------------------------------------------------
;; Platform-dependent settings
;;
;; this may load some projects which are also platform-dependent.
;; ----------------------------------------------------------------------
(setq system-type-specific-config (concat EMACS_HOME "/platform/"
                                          (replace-regexp-in-string "/" "_" (prin1-to-string system-type))
                                          ".el"))
(if (file-exists-p system-type-specific-config) (load system-type-specific-config))

