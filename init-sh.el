(add-hook 'sh-set-shell-hook 'flymake-shell-load)

(add-auto-mode 'shell-script-mode "\\.zsh")


(provide 'init-sh)
