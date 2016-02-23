(setq DROPBOX "~")

;; Feature control
(setq use-org-mode nil
      use-git-mode nil
      use-cedet nil                       ;for android/java
      use-jdee nil
      use-tabbar nil
      use-ws-butler nil                 ; remove whitespaces
      use-helm nil
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
    ("71ecffba18621354a1be303687f33b84788e13f40141580fa81e7840752d31bf" "28ec8ccf6190f6a73812df9bc91df54ce1d6132f18b4c8fcc85d45298569eb53" "f8fceb5cce25882d0842aac0e75000bc1a06e3c4eac89b61103c6dbfa88e40ad" "4f5bb895d88b6fe6a983e63429f154b8d939b4a8c581956493783b2515e22d6d" "ad950f1b1bf65682e390f3547d479fd35d8c66cafa2b8aa28179d78122faa947" "74d9d61cb5280832ed33110cf83b8a1cb83bec5c18509cdbfb0ba94c41e34b71" "9b402e9e8f62024b2e7f516465b63a4927028a7055392290600b776e4a5b9905" "405b0ac2ac4667c5dab77b36e3dd87a603ea4717914e30fcf334983f79cfd87e" "94ba29363bfb7e06105f68d72b268f85981f7fba2ddef89331660033101eb5e5" default)))
 '(default-input-method "chinese-zozy"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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
(add-hook 'c++-mode-hook 'snps-c++-mode-hook)
(add-hook 'c-mode-hook 'snps-c-mode-hook)
