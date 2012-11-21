(eval-after-load "undo-tree"
  '(progn
     (require 'undo-tree)
     (global-undo-tree-mode)

     ;; Represent undo-history as an actual tree (visualize with C-x u)
     (setq undo-tree-mode-lighter "")))


(provide 'init-undo-tree)
