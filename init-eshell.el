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
   user-login-name "@" system-name " "
   (abbreviate-file-name
    (eshell/pwd))
   (when (magit-get-current-branch)
     (with-face (format " (%s)" (magit-get-current-branch)) :foreground "blue"))
   (if (= (user-uid) 0)
       (with-face " #" :foreground "red")
     " $")
   " "))
(setq eshell-prompt-function 'shk-eshell-prompt)

(defun colorfy-eshell-prompt ()
  "Colorfy eshell prompt according to `user@hostname' regexp."
  (let* ((mpoint)
         (user-string-regexp (concat "^" user-login-name "@" system-name)))
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward (concat user-string-regexp ".*[$#]") (point-max) t)
        (setq mpoint (point))
        (overlay-put (make-overlay (point-at-bol) mpoint) 'face '(:foreground "dodger blue")))
      (goto-char (point-min))
      (while (re-search-forward user-string-regexp (point-max) t)
        (setq mpoint (point))
        (overlay-put (make-overlay (point-at-bol) mpoint) 'face '(:foreground "green3"))
        ))))

;; Make eshell prompt more colorful
(add-to-list 'eshell-output-filter-functions 'colorfy-eshell-prompt)

;;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)
;;; Change default mail to "C-x M"
(global-set-key (kbd "C-x M") 'compose-mail)

(provide 'init-eshell)
