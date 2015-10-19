;; ==================================================
;; Configuration only for Emacs/cygwin
;; ==================================================

;; projects
(and (boundp 'use-cedet) use-cedet
     (progn
       ;; common java projects
       (load "~/Settings/Emacs/project.el")
       )
     )

