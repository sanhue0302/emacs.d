(require-package 'cl-lib '(0 2))
(require 'cl-lib)

(defun locale-is-utf8-p ()
  "Return t iff the \"locale\" command or environment variables prefer UTF-8."
  (cl-flet ((is-utf8 (v) (and v (string-match "UTF-8" v))))
    (or (is-utf8 (and (executable-find "locale") (shell-command-to-string "locale")))
        (is-utf8 (getenv "LC_ALL"))
        (is-utf8 (getenv "LC_CTYPE"))
        (is-utf8 (getenv "LANG")))))

(when (or window-system (locale-is-utf8-p))
  (setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
  (set-language-environment 'utf-8)
  (setq locale-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (unless (eq system-type 'windows-nt)
   (set-selection-coding-system 'utf-8))
  (prefer-coding-system 'utf-8))

(provide 'init-locales)
