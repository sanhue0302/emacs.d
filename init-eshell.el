;;; http://sakito.jp/emacs/emacsshell.html
(setq system-uses-terminfo nil)

;;; use emacs in eshell
(add-hook 'eshell-mode-hook
          '(lambda nil
             (eshell/export "EDITOR=emacsclient -n")
             (eshell/export "VISUAL=emacsclient -n")))

;;; set prompt for eshell
(defmacro with-face (str &rest properties)
    `(propertize ,str 'face (list ,@properties)))

(defun shk-eshell-prompt ()
  (concat
   (abbreviate-file-name
    (eshell/pwd))
   (when (magit-get-current-branch)
     (with-face (format " (%s)" (magit-get-current-branch)) :foreground "blue"))
   (if (= (user-uid) 0)
       (with-face " #" :foreground "red")
     " $")
   " "))
(setq eshell-prompt-function 'shk-eshell-prompt)

;;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)
;;; Change default mail to "C-x M"
(global-set-key (kbd "C-x M") 'compose-mail)

(provide 'init-eshell)
