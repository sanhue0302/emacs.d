(require-package 'flymake-shell)
(add-hook 'sh-set-shell-hook 'flymake-shell-load)

(add-auto-mode 'shell-script-mode "\\.zsh")

;;; http://sakito.jp/emacs/emacsshell.html
(setq system-uses-terminfo nil)


(provide 'init-sh)
