(eval-after-load "twittering-mode"
  '(progn
     (require 'twittering-mode)

     ;; Avoid to setup password each times
     (setq twittering-use-master-password t)))

(provide 'init-twittering)
