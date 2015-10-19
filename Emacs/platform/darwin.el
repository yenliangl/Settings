(require 'mouse)
(xterm-mouse-mode t)
(defun track-mouse (e))

;; projects
(and (boundp 'use-cedet) use-cedet
     (progn
       (load "~/Settings/Emacs/project.el")
       )
     )
