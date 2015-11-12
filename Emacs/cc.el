;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; _+ C/C++ stuff
;;
(require 'cc-mode)

(add-hook 'c-mode-common-hook
          (lambda ()
            (setq show-trailing-whitespace t)
            (hs-minor-mode)
            (doxymacs-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;_+ C/C++ Mode
;;
(setq auto-mode-alist
      (append '(
                ("\\.cc$"  . c++-mode)
                ("\\.c$"   . c-mode)
                ("\\.C$"   . c++-mode)
                ("\\.Ct$"   . c++-mode)
                ("\\.cc$"  . c++-mode)
                ("\\.c$"   . c-mode)
                ("\\.cxx$" . c++-mode)
                ("\\.cpp$" . c++-mode)
                ("\\.inl$" . c++-mode)
                ("\\.ht$" . c++-mode)
                ("\\.h$"   . c++-mode))
              auto-mode-alist))
(setq kill-whole-line t
      c-hungry-delete-key t
      c-auto-newline 1
      comment-multi-line t)

;; ----------------------------------------------------------------------
;; Kde-emacs
;; ----------------------------------------------------------------------
(load-file (concat EMACS_HOME "/kde-emacs.el"))
(add-hook 'c++-mode-hook 'kde-c++-mode-hook)
(add-hook 'c-mode-hook 'kde-c-mode-hook)
; always end a file with a newline
(setq-default require-final-newline t)
; 'next-line won't be adding newlines
(setq-default next-line-add-newlines nil)

(if kde-emacs-newline-semicolon
    (define-key c++-mode-map "\;" 'insert-semicolon))
(unless use-cedet
  (progn
    ;; (setq kde-use-pc-select nil)            ;don't use pc-select
    (setq magic-keys-mode t)
    (load-file (concat EMACS_HOME "/kde-emacs-bindings.el"))))
