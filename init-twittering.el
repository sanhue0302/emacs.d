(require-package 'twittering-mode)

;; Avoid to setup password each times
(setq twittering-use-master-password t)

;; favorite/unfavorite hotkey
(define-key twittering-mode-map (kbd "C-c f") 'twittering-favorite)
(define-key twittering-mode-map (kbd "C-c F") 'twittering-unfavorite)

;; setup hotkey
(global-set-key (kbd "C-x t") 'twit)

(provide 'init-twittering)
