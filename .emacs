(setq use-org-mode nil
      use-jdee nil)

(setq DROPBOX "~")
(load-file (expand-file-name "~/Settings/Emacs/emacs.el"))

(setq user-full-name "Liu Yen-Liang (David)")
(setq user-mail-address "yenliang@synopsys.com")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom variable and faces
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
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

(menu-bar-mode -1)

(remove-hook 'before-save-hook 'delete-trailing-whitespace)

(setq gdb-many-windows t
      compilation-scroll-output t)

;; customize compile mode for StarRC
;;     main.C  Master.hier  Master.make
(define-key c++-mode-map [(f8)] 'my-synmake-compile-command)
(define-key c++-mode-map [(f9)] 'my-synmake-g-compile-command)

(defun my-synmake-compile-command ()
  (interactive)
  (set (make-local-variable 'compile-command)
       (concat "/depot/qsc/QSCH/bin/synmake TARGET_ARCH=" (getenv "TARGET_ARCH") " -C " default-directory))
  ;; (setq current-prefix-arg '(4))        ;C-u
  (call-interactively 'compile))

(defun my-synmake-g-compile-command ()
  (interactive)
  (set (make-local-variable 'compile-command)
       (concat "/depot/qsc/QSCH/bin/synmake BUILD_TYPE=pure TARGET_ARCH=" (getenv "TARGET_ARCH") " exec-g -C " default-directory))
  (call-interactively 'compile))

;; (if (<= emacs-major-version 23)
;;     (setq gud-gdb-command-name "/depot/gdb-7.5/bin/gdb --annotate=3 ")
;;   (setq gud-gdb-command-name "/depot/gdb-7.5/bin/gdb --i=mi "))

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
