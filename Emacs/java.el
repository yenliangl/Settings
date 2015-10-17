;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setting for Jave Programming Environment.
;;

;; Sets the basic indentation for Java source files
;; to two spaces.

(setq-default indent-tabs-mode nil)
(defun fill-column-hook () (setq fill-column 80)) ; use 80 column width
(defun comment-column-hook () (setq comment-column 40)) ; start comments in column 40

;; cedet must be loaded before this file.
(defun my-java-mode-hook ()
  (font-lock-mode)

  ;; --------------------------------------------------
  ;; From kde-c++-mode-hook
  ;; --------------------------------------------------
  ;; (define-key java-mode-map "\C-m"  'c-context-line-break)
  ;; (when (or (eq kde-tab-behavior 'default)
  ;;           (eq kde-tab-behavior 'abbrev-indent))
  ;;   (define-key java-mode-map "\C-i" 'agulbra-c++-tab))
  ;; (define-key java-mode-map "\ef" 'c-forward-into-nomenclature)
  ;; (define-key java-mode-map "\eb" 'c-backward-into-nomenclature)
  ;; ;; Add (setq magic-keys-mode nil) to your .emacs (before loading this file)
  ;; ;; to disable the magic keys in C++ mode.
  ;; (and (boundp 'magic-keys-mode) magic-keys-mode
  ;;      (progn
  ;; ;;        ;; (define-key java-mode-map "\(" 'insert-parens)
  ;; ;;        ;; (define-key java-mode-map "\)" 'insert-parens2)
  ;;        (define-key java-mode-map "\," 'insert-comma)
  ;; ;;        (define-key java-mode-map "\{" 'insert-curly-brace)
  ;;        ))

  ;; --------------------------------------------------
  ;; My customization
  ;; --------------------------------------------------
  (setq show-trailing-whitespace t)
  ;; (setq c-basic-offset 4)
  ;; (turn-off-auto-fill)
  ;; (setq c-comment-start-regexp "\\(@\\|/\\(/\\|[*][*]?\\)\\)")
  (modify-syntax-entry ?@ "< b" java-mode-syntax-table)
  (local-set-key (quote [C-return]) (quote jde-complete))
)
(add-hook 'java-mode-hook 'my-java-mode-hook)
