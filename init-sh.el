(require-package 'flymake-shell)
(add-hook 'sh-set-shell-hook 'flymake-shell-load)

(add-auto-mode 'shell-script-mode "\\.zsh")

;;; http://sakito.jp/emacs/emacsshell.html
(setq system-uses-terminfo nil)

;;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)
;;; Change default mail to "C-x M"
(global-set-key (kbd "C-x M") 'compose-mail)

(provide 'init-sh)
