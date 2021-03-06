;;; start edit-server
(require-package 'edit-server)
(edit-server-start)

;; kill this buffer, also can kill client
(add-hook 'server-switch-hook
          (lambda ()
            (when (current-local-map)
              (use-local-map (copy-keymap (current-local-map))))
            (when server-buffer-clients
              (local-set-key (kbd "C-x k") 'server-edit))))

(provide 'init-client)
