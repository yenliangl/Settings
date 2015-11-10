(add-hook 'c++-mode-hook 'kde-c++-mode-hook)
(add-hook 'c-mode-hook 'kde-c-mode-hook)
; always end a file with a newline
(setq-default require-final-newline t)
; 'next-line won't be adding newlines
(setq-default next-line-add-newlines nil)

(if kde-emacs-newline-semicolon
    (define-key c++-mode-map "\;" 'insert-semicolon))
(define-key c++-mode-map [(f6)] 'kde-switch-cpp-h)
(define-key c-mode-map [(f6)] 'kde-switch-cpp-h)
(define-key c++-mode-map [(f7)] 'switch-to-function-def)
(define-key global-map [(meta n)] 'next-error)

(define-key global-map [(control backspace)] 'backward-kill-word)
(define-key global-map [(control delete)] 'kill-word)
(define-key global-map [(control prior)] 'beginning-of-buffer)
(define-key global-map [(control next)] 'end-of-buffer)
