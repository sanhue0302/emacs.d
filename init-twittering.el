(require 'twittering-mode)

;; Avoid to setup password each times
(setq twittering-use-master-password t)

;; setup hotkey
(global-set-key (kbd "C-x t") 'twit)

(provide 'init-twittering)
