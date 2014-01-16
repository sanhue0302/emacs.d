(require-package 'twittering-mode)
(require 'twittering-mode)

;; Avoid to setup password each times
(setq twittering-use-master-password t)

;; favorite/unfavorite hotkey
(define-key twittering-mode-map (kbd "C-c f") 'twittering-favorite)
(define-key twittering-mode-map (kbd "C-c F") 'twittering-unfavorite)

;; rebind hotkey
(define-key twittering-mode-map (kbd "[") 'twittering-switch-to-previous-timeline)
(define-key twittering-mode-map (kbd "]") 'twittering-switch-to-next-timeline)
(define-key twittering-mode-map (kbd "f") 'twittering-other-user-timeline)
(define-key twittering-mode-map (kbd "b") 'twittering-goto-first-status)

;; i-search
(define-key twittering-mode-map (kbd "s") 'isearch-forward)

;; setup hotkey
(global-set-key (kbd "C-x t") 'twit)

;; setup status-format
(twittering-update-status-format "%i %S @%s,  %@:\n%FILL{  %T // from %f%L%r%R}\n")

(provide 'init-twittering)
