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
                ("\\.cc$"  . c++-mode)
                ("\\.c$"   . c-mode)
                ("\\.cxx$" . c++-mode)
                ("\\.cpp$" . c++-mode)
                ("\\.inl$" . c++-mode)
                ("\\.h$"   . c++-mode))
              auto-mode-alist))
(setq kill-whole-line t
      c-hungry-delete-key t
      c-auto-newline 1
      comment-multi-line t)

;; ----------------------------------------------------------------------
;; Kde-emacs
;; ----------------------------------------------------------------------
(unless use-cedet
  (progn
    ;; (setq kde-use-pc-select nil)            ;don't use pc-select
    (setq magic-keys-mode t)
    (load-file (concat EMACS_HOME "/kde-emacs.el"))))

