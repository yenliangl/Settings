(setq DROPBOX "~")

;; Feature control
(setq use-org-mode nil
      use-git-mode nil
      use-cedet nil                       ;for android/java
      use-jdee nil
      use-tabbar nil
      use-ecb nil)

(load-file (expand-file-name "~/Settings/Emacs/emacs.el"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom variable and faces
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(default-input-method "chinese-zozy"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(comint-highlight-prompt ((t (:foreground "light blue"))))
 '(minibuffer-prompt ((t (:foreground "red")))))

(when window-system
  (progn
    (set-fontset-font "fontset-default"
                      'han '("MingLan" . "unicode-bmp"))))


(setq gdb-many-windows t
      compilation-scroll-output t)

;; customize compile mode for StarRC
;;     main.C  Master.hier  Master.make
(define-key c++-mode-map [(f8)] 'my-synmake-compile-command)
(define-key c++-mode-map [(f9)] 'my-synmake-g-compile-command)

(defun my-synmake-compile-command ()
  (interactive)
  (set (make-local-variable 'compile-command)
       (concat "/depot/qsc/QSCK/bin/synmake TARGET_ARCH=" (getenv "TARGET_ARCH") " -j 'localhost:4,starrc02:2,starrc04:2,starrc07:2' -C " default-directory))
  ;; (setq current-prefix-arg '(4))        ;C-u
  (call-interactively 'compile))

(defun my-synmake-g-compile-command ()
  (interactive)
  (set (make-local-variable 'compile-command)
       (concat "/depot/qsc/QSCK/bin/synmake BUILD_TYPE=pure TARGET_ARCH=" (getenv "TARGET_ARCH") " -j 'localhost:4,starrc02:2,starrc04:2,starrc07:2' install-debug -C " default-directory))
  (call-interactively 'compile))

;; (if (<= emacs-major-version 23)
;;     (setq gud-gdb-command-name "/depot/gdb-7.5/bin/gdb --annotate=3 ")
;;   (progn
;;     (setq gud-gdb-command-name "/depot/undodb/undodb-4.0.162/undodb-gdb --annotate=3 --undodb-gdb-exe /depot/gdb-7.6.2/bin/gdb")
;;     (setq gud-gud-gdb-command-name "/depot/undodb/undodb-4.0.162/undodb-gdb --annotate=3 --undodb-gdb-exe /depot/gdb-7.6.2/bin/gdb")))
(setq gdb-create-source-file-list nil)

;; ----------------------------------------------------------------------
;; Perforce
;; ----------------------------------------------------------------------
(load-library "p4")

(setq auto-mode-alist
     (append '(("\\.make$" . makefile-mode)
               ("\\.hier$" . makefile-mode)
               )
             auto-mode-alist))
(setq p4-file-refresh-timer-time 0)

;; ----------------------------------------------------------------------
;; My Programming Style
;; ----------------------------------------------------------------------
(defun snps-c-mode-hook ()
  (c-set-style kde-c-style))
(defun snps-c++-mode-hook ()
  (c-set-style kde-c++-style))
(add-hook 'c++-mode-hook 'my-c-mode-hook)
(add-hook 'c-mode-hook 'my-c-mode-hook)
