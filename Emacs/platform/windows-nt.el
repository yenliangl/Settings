;; ==================================================
;; Configuration for Emacs/W32.
;; ==================================================

;;
;; Load cygwin settings for windows-version of Emacs
;;
(when (file-directory-p "c:/cygwin/bin")
  (progn
    (setenv "PATH" (concat "c:/cygwin/bin;" (getenv "PATH")))
    (setq exec-path (cons "c:/cygwin/bin/" exec-path))))

;; LOGNAME and USER are expected in many Emacs packages
;; Check these environment variables.
(if (and (null (getenv "USER"))
         ;; Windows includes variable USERNAME, which is copied to
         ;; LOGNAME and USER respectively.
         (getenv "USERNAME"))
    (setenv "USER" (getenv "USERNAME")))

(if (and (getenv "LOGNAME")
         ;;  Bash shell defines only LOGNAME
         (null (getenv "USER")))
    (setenv "USER" (getenv "LOGNAME")))

(if (and (getenv "USER")
         (null (getenv "LOGNAME")))
    (setenv "LOGNAME" (getenv "USER")))

(require 'cygwin-mount)
(cygwin-mount-activate)

;; Add Cygwin Info pages
(setq Info-default-directory-list (append Info-default-directory-list (list "c:/cygwin/usr/info/")))

(setq w32-quote-process-args ?\") ;; " @@@ IS THIS BETTER? ;@@@ WAS THIS BEFORE: (setq w32-quote-process-args t)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (A) M-x shell: This change M-x shell permanently
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq shell-file-name "bash")
;; (setenv "SHELL" shell-file-name)
;; (setq explicit-shell-file-name shell-file-name)
;; (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m) ; Remove C-m (^M) characters that appear in output

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (B) *OR* call following function with M-x my-bash
;; The M-x shell would continue to run standard Windows shell
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my-bash (&optional buffer)
  "Run Cygwin Bash shell in optional BUFFER; default *shell-bash*."
  (autoload 'comint-check-proc "comint")
  (interactive
   (let ((name "*shell-bash*"))
     (if current-prefix-arg
         (setq name (read-string
                     (format "Cygwin shell buffer (default %s): " name)
                     (not 'initial-input)
                     (not 'history)
                     name)))
     (list name)))
  (or buffer
      (setq buffer "*shell-bash*"))
  (if (comint-check-proc buffer)
      (pop-to-buffer buffer)
    (let* ((shell-file-name            "bash")
           (explicit-shell-file-name   shell-file-name)
           (explicit-sh-args           '("--login" "-i"))
           (explicit-bash-args         explicit-sh-args)
           (w32-quote-process-args     ?\"));; Use Cygwin quoting rules.
      (shell buffer)
      ;;  By default Emacs sends "\r\n", but bash wants plain "\n"
      (set-buffer-process-coding-system 'undecided-dos 'undecided-unix)
      ;; With TAB completion, add slash path separator, none to filenames
      (make-local-variable 'comint-completion-addsuffix)
      (setq comint-completion-addsuffix '("/" . ""))
      ;;  This variable is local to buffer
      (setq comint-prompt-regexp "^[ \n\t]*[$] ?"))))
