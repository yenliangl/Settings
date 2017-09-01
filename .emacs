
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq DROPBOX "~/Dropbox")

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
    ("64f2981274fd8740b794bce9feee7949ed87b88fc0b4654bd98594e1aa81abcd" "0ad9ed23b1f323e4ba36a7f0cbef6aff66128b94faa473aacd79317fbd24abda" "6254372d3ffe543979f21c4a4179cd819b808e5dd0f1787e2a2a647f5759c1d1" "1160f5fc215738551fce39a67b2bcf312ed07ef3568d15d53c87baa4fd1f4d4e" "1db337246ebc9c083be0d728f8d20913a0f46edc0a00277746ba411c149d7fe5" "cc0dbb53a10215b696d391a90de635ba1699072745bf653b53774706999208e3" "1fab355c4c92964546ab511838e3f9f5437f4e68d9d1d073ab8e36e51b26ca6a" "39dd7106e6387e0c45dfce8ed44351078f6acd29a345d8b22e7b8e54ac25bac4" "a1289424bbc0e9f9877aa2c9a03c7dfd2835ea51d8781a0bf9e2415101f70a7e" "705f3f6154b4e8fac069849507fd8b660ece013b64a0a31846624ca18d6cf5e1" "9122dfb203945f6e84b0de66d11a97de6c9edf28b3b5db772472e4beccc6b3c5" "cc60d17db31a53adf93ec6fad5a9cfff6e177664994a52346f81f62840fe8e23" "0b6645497e51d80eda1d337d6cabe31814d6c381e69491931a688836c16137ed" "91fba9a99f7b64390e1f56319c3dbbaed22de1b9676b3c73d935bf62277b799c" "aae95fc700f9f7ff70efbc294fc7367376aa9456356ae36ec234751040ed9168" "763ec64e70865901709b9927b0bef397a7b6a90fcff9c13c82a51f1678f118e7" "45712b65018922c9173439d9b1b193cb406f725f14d02c8c33e0d2cdad844613" "631ec9c41948954ab4b51d801742f80388a06f264638fe241f64706fc87ba868" "51e228ffd6c4fff9b5168b31d5927c27734e82ec61f414970fc6bcce23bc140d" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "71ecffba18621354a1be303687f33b84788e13f40141580fa81e7840752d31bf" "28ec8ccf6190f6a73812df9bc91df54ce1d6132f18b4c8fcc85d45298569eb53" "f8fceb5cce25882d0842aac0e75000bc1a06e3c4eac89b61103c6dbfa88e40ad" "4f5bb895d88b6fe6a983e63429f154b8d939b4a8c581956493783b2515e22d6d" "ad950f1b1bf65682e390f3547d479fd35d8c66cafa2b8aa28179d78122faa947" "74d9d61cb5280832ed33110cf83b8a1cb83bec5c18509cdbfb0ba94c41e34b71" "9b402e9e8f62024b2e7f516465b63a4927028a7055392290600b776e4a5b9905" "405b0ac2ac4667c5dab77b36e3dd87a603ea4717914e30fcf334983f79cfd87e" "94ba29363bfb7e06105f68d72b268f85981f7fba2ddef89331660033101eb5e5" default)))
 '(default-input-method "chinese-zozy")
 '(package-selected-packages
   (quote
    (smart-tabs-mode diffview gnugo ztree ace-window ample-theme google-c-style gradle-mode smart-compile twilight-theme atom-dark-theme atom-one-dark-theme ample-zen-theme yasnippet async dash epl git-commit helm-core hydra magit-popup pkg-info with-editor helm ws-butler sr-speedbar smartparens quasi-monochrome-theme projectile popup pandoc-mode p4 monochrome-theme minimal-theme magit jbeans-theme java-snippets distinguished-theme company common-lisp-snippets bison-mode))))

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
;; (define-key c++-mode-map [(f8)] 'my-synmake-compile-command)

(defun my-synmake-compile-command ()
  (interactive)
  (set (make-local-variable 'compile-command)
       (concat (getenv "SYNMAKE") " TARGET_ARCH=" (getenv "TARGET_ARCH") " install-develop -C " default-directory))
  (call-interactively 'compile))

(defun my-synmake-g-compile-command ()
  (interactive)
  (set (make-local-variable 'compile-command)
       (concat (getenv "SYNMAKE") " TARGET_ARCH=" (getenv "TARGET_ARCH") " install-debug -C " default-directory))
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

;; ----------------------------------------------------------------------
;; multi-compile
;; ----------------------------------------------------------------------
(require 'multi-compile)
(setq multi-compile-alist
      '((c++-mode . (("smake-d"     . "/depot/qsc/QSCM/bin/synmake -j starQSCM -C %dir install-develop")
                     ; ("smake-g"     . "/depot/qsc/QSCM/bin/synmake -j starQSCM -C %dir install-debug")
                     ; ("smake-c"     . "/depot/qsc/QSCM/bin/synmake -j starQSCM -C %dir check")
                     ("smake-dbXtract-d" "cd dbXtract; /depot/qsc/QSCM/bin/synmake -j starQSCM install-develop" (multi-compile-locate-file-dir project))
                     ("smake-xTractor-d" "cd nextract; /depot/qsc/QSCM/bin/synmake -j starQSCM install-develop" (multi-compile-locate-file-dir project))
                     ("gtest_unit"       "cd gtest/gtest_unit; /depot/qsc/QSCM/bin/synmake -j starQSCM check" (multi-compile-locate-file-dir (getenv "PROJECT")))
                     ("make" "make" (multi-compile-locate-file-dir "dbxtract"))
                     ))
        ;; Other modes
        ))
(setq multi-compile-completion-system 'ido)
(define-key c++-mode-map [(f8)] 'multi-compile-run)
(define-key c++-mode-map [(f9)] 'my-synmake-compile-command)

(let ((path (shell-command-to-string "source ~/.cshrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path
        (append
         (split-string-and-unquote path ":")
         exec-path)))

;; List our sites
(setq display-time-world-list
      '(("Asia/Taipei"           "Taipei")
        ("Europe/Paris"          "Paris")
        ("America/Los_Angeles"   "San Francisco")
        ("Asia/Shanghai"         "Shanghai")))
(display-time-world)
