(define-key c++-mode-map [(f6)] 'kde-switch-cpp-h)
(define-key c-mode-map [(f6)] 'kde-switch-cpp-h)
(define-key c++-mode-map [(f7)] 'switch-to-function-def)
(define-key global-map [(meta n)] 'next-error)

(define-key global-map [(control backspace)] 'backward-kill-word)
(define-key global-map [(control delete)] 'kill-word)
(define-key global-map [(control prior)] 'beginning-of-buffer)
(define-key global-map [(control next)] 'end-of-buffer)
