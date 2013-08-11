(require-package 'markdown-mode)

(setq auto-mode-alist
      (cons '("\\.\\(md\\|markdown\\)\\'" . markdown-mode) auto-mode-alist))

(defun marked-markdown-preview ()
  "run Marked on the current file if Marked is installed;
otherwise fallback to markdown-preview"
  (interactive)
  (let ((marked-app "/Applications/Marked.app"))
    (if (file-exists-p marked-app)
        (shell-command
         (format (concat "open -a " marked-app " %s")
                 (shell-quote-argument (buffer-file-name))))
      (markdown-preview))
    ))

(eval-after-load 'markdown-mode
  '(progn
     (define-key markdown-mode-map (kbd "C-c C-v") 'marked-markdown-preview)
     ))

(provide 'init-markdown)
