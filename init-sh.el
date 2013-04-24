(require-package 'flymake-shell)
(add-hook 'sh-set-shell-hook 'flymake-shell-load)

(add-auto-mode 'shell-script-mode "\\.zsh")
;;; change default shell to zsh
(defvar local-zsh "/usr/local/bin/zsh")
(when (file-exists-p local-zsh)
      (setenv "SHELL" local-zsh))

;;; http://sakito.jp/emacs/emacsshell.html
(setq system-uses-terminfo nil)

;;; use emacs in eshell
(add-hook 'eshell-mode-hook
          '(lambda nil
             (eshell/export "EDITOR=emacsclient -n")
             (eshell/export "VISUAL=emacsclient -n")))

;;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)
;;; Change default mail to "C-x M"
(global-set-key (kbd "C-x M") 'compose-mail)

(provide 'init-sh)
