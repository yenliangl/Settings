;; ----------------------------------------------------------------------
;; CEDET for Emacs 23+
;; ----------------------------------------------------------------------

;; suppress warning message of "cedet-called-interactively-p called with 0
;; arguments, but requires 1".
(setq byte-compile-warning nil)

(load-file (concat LISP_HOME "/cedet/trunk/cedet-devel-load.el"))
;; Enable EDE (Project Management) features
(global-ede-mode t)

;; (semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)
(global-srecode-minor-mode 1)
