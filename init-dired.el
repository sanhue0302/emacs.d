(require-package 'dired+)

(setq diredp-hide-details-initially-flag nil)
(setq global-dired-hide-details-mode -1)

(after-load 'dired
  (require 'dired+)
  (setq dired-recursive-deletes 'top)
  (define-key dired-mode-map [mouse-2] 'dired-find-file))

(defun dired-show-only (regexp)
   (interactive "sFiles to show (regexp): ")
   (dired-mark-files-regexp regexp)
   (dired-toggle-marks)
   (dired-do-kill-lines))

(eval-after-load 'dired+
  '(progn
     (define-key dired-mode-map (kbd "/") 'dired-show-only)))

(provide 'init-dired)
