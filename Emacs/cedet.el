;; ----------------------------------------------------------------------
;; CEDET for Emacs 24
;; ----------------------------------------------------------------------

;; suppress warning message of "cedet-called-interactively-p called with 0
;; arguments, but requires 1".
(setq byte-compile-warning nil)

(setq CEDET_HOME (file-name-as-directory (concat LISP_HOME "/cedet/trunk/")))
(load-file (concat CEDET_HOME "cedet-devel-load.el"))
(add-to-list 'load-path (concat CEDET_HOME "contrib"))

;; select which submodes we want to activate
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completion-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)

;; Activate semantic
(semantic-mode 1)

;; load contrib library
(require 'eassist)
(require 'semantic/senator)

;; customisation
(defun my-agulbra-c++-tab (arg)
  "Do the right thing about tabs in c++ mode.
Try to finish the symbol, or indent the line."
  (interactive "*P")
  (cond
   ((and (not (looking-at "[A-Za-z0-9]"))
         (save-excursion
           (forward-char -1)
           (looking-at "[A-Za-z0-9:>_\\-\\&\\.(){}\\*\\+/]")))
    ;; (senator-complete-symbol))
    (semantic-ia-complete-symbol))
   (t
    (c-indent-command))))

(defun alexott/cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
  ;; (local-set-key "."     'semantic-complete-self-insert)
  ;;
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)

  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  )
(add-hook 'c-mode-common-hook 'alexott/cedet-hook)
(add-hook 'java-mode-hook 'alexott/cedet-hook)
(add-hook 'lisp-mode-hook 'alexott/cedet-hook)
;(add-hook 'scheme-mode-hook 'alexott/cedet-hook)
(add-hook 'emacs-lisp-mode-hook 'alexott/cedet-hook)
;(add-hook 'erlang-mode-hook 'alexott/cedet-hook)

(defun yenliangl/java-mode-cedet-hook ()
  (local-set-key "\C-i"  'my-agulbra-c++-tab)
)
(defun alexott/c-mode-cedet-hook ()
  (local-set-key "\C-i"  'my-agulbra-c++-tab)
  ;;(local-set-key "->"    'semantic-complete-self-insert)

  (local-set-key "\C-ct" 'eassist-switch-h-cpp)
  (local-set-key "\C-xt" 'eassist-switch-h-cpp)
  (local-set-key  (kbd "<f6>") 'eassist-switch-h-cpp)
  (local-set-key  (kbd "<f7>") 'eassist-list-methods)
  (local-set-key "\C-ce" 'eassist-list-methods)
  (local-set-key "\C-c\C-r" 'semantic-symref)
  )
(add-hook 'c-mode-common-hook 'alexott/c-mode-cedet-hook)
(add-hook 'java-mode-hook 'yenliangl/java-mode-cedet-hook)
(when (cedet-gnu-global-version-check t)
  (semanticdb-enable-gnu-global-databases 'c-mode )
  (semanticdb-enable-gnu-global-databases 'c++-mode))

(when (cedet-ectag-version-check t)
  (semantic-load-enable-primary-ectags-support))

;; SRecode
(global-srecode-minor-mode 1)

;; EDE
(global-ede-mode 1)
(ede-enable-generic-projects)

;; Setup JAVA.
(require 'cedet-java)
(require 'semantic/db-javap)
(setq cedet-java-jdk-root (getenv "JAVA_HOME"))

;; some java projects I'm working on
(ede-java-root-project "bitcoinj"
                       :file "~/Work/bitcoinj/README.md"
                       :srcroot '("core/src/main/java"
                                  "examples/src/main/java"
                                  "orchid/src/"
                                  "tools/src/main/java"
                                  "wallettemplate/src/main/java"))
