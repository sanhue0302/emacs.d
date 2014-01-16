(when (< emacs-major-version 24)
  (require-package 'org))
(require-package 'org-fstree)
(when *is-a-mac*
  (require-package 'org-mac-link)
  (require-package 'org-mac-iCal))


(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)

;; Various preferences
(setq org-log-done t
      org-completion-use-ido t
      org-edit-timestamp-down-means-later t
      org-agenda-start-on-weekday nil
      org-agenda-span 14
      org-agenda-include-diary t
      org-agenda-window-setup 'current-window
      org-fast-tag-selection-single-key 'expert
      org-export-kill-product-buffer-when-displayed t
      org-tags-column 80)


; Refile targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5))))
; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))
; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)
; enable speed-commands, default value define in 'org-speed-commands-default
(setq org-use-speed-commands t)
; always hide leading-stars
(setq org-hide-leading-stars t)

; GTD rule
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "MEETING"))))

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING" . t) ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "Cyan" :weight bold)
              ("DONE" :foreground "green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "brown" :weight bold)
              ("MEETING" :foreground "forest green" :weight bold))))

(setq org-tag-alist '((:startgroup)
                     ("@Office" . ?o)
                     ("@Home" . ?h)
                     ("@Computer" . ?c)
                     (:endgroup)

                     ("@Reading" . ?r)
                     (:grouptags)
                     ("@Reading_book" . nil)
                     ("@Reading_web" . nil)

                     (:endgroup)
                     ("@Gaming" . ?g)
                     ("@Watching" . ?w)))

(setq org-capture-templates
      (quote (("i" "Idea has to catch up" entry
               (file+headline "~/org/refile.org" "Idea")
               "")
              ("t" "Todo sometings" entry
               (file+headline "~/org/refile.org" "Tasks")
               "* TODO %?")
              ("n" "Note about anything" entry
               (file+headline "~/org/refile.org" "Note")
               "")
              ("r" "Something to reading or learning" entry
               (file+headline "~/org/refile.org" "Idea")
               "* Reading %? :@Reading:")
              ("w" "Watching something" entry
               (file+headline "~/org/refile.org" "Idea")
               "* 看 %? :@Watching:")
              ("m" "Meeting with somebody" entry
               (file+headline "~/org/refile.org" "Meeting")
               "* MEETING with %? ")
              ("j" "Interruption" entry
               (file+headline "~/org/refile.org" "Interruption")
               ""))))

(setq org-agenda-custom-commands
      (quote (("k" "Use org-capture capture somethings" org-capture "" nil)
              ("d" "Daily action list" agenda ""
               ((org-agenda-ndays 1)
                (org-agenda-sorting-strategy
                 (quote (time-up priority-down tag-up)))
                (org-deadline-warning-days 0)))
              ("H" "List all special tags at agenda files"
               ((agenda "" nil)
                (tags-todo "-CANCELLED/!NEXT"
                           ((org-agenda-overriding-header "Next Tasks")
                            (org-agenda-skip-function t)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-todo-ignore-with-date t)
                            (org-agenda-sorting-strategy
                             '(priority-down todo-state-down effort-up category-keep))))
                (tags-todo "@Office/-DONE"
                           ((org-agenda-overriding-header "List TODO with @Office")))
                (tags-todo "@Home/-DONE"
                           ((org-agenda-overriding-header "List TODO with @Home")))
                (tags-todo "@Reading|@Reading_web|@Reading_book/-DONE"
                           ((org-agenda-overriding-header "List TODO with @Reading")))
                (tags-todo "@Computer/-DONE"
                           ((org-agenda-overriding-header "List TODO with @Computer")))
                (tags-todo "@Watching/-DONE"
                           ((org-agenda-overriding-header "List TODO with @Watching")))
                (tags-todo "@Gaming/-DONE"
                           ((org-agenda-overriding-header "List TODO with @Gaming"))))
               ((org-agenda-sorting-strategy '(priority-up effort-down))))
              ("h" . "GTD contexts")
              ("ho" "Office" tags-todo "@Office")
              ("hh" "Home" tags-todo "@Home")
              ("hc" "Computer" tags-todo "@Computer")
              ("hr" "Reading" tags-todo "@Reading|@Reading_web|@Reading_book")
              ("hw" "Watching" tags-todo "@Watching")
              ("hg" "Gaming" tags-todo "@Gaming")
              ("r" "Tasks to Refile" todo "TODO"
               ((org-agenda-files (quote ("~/org/refile.org")))))
              ("n" "Next Actions" todo "NEXT" nil))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org clock
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persistence-insinuate t)
(setq org-clock-persist t)
(setq org-clock-in-resume t)

;; Change task state to STARTED when clocking in
(setq org-clock-in-switch-to-state "NEXT")
;; Save clock data and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; while minutes lass than 2, don't log
(setq org-clock-rounding-minutes 2)

;; Show the clocked-in task - if any - in the header line
(defun sanityinc/show-org-clock-in-header-line ()
  (setq-default header-line-format '((" " org-mode-line-string " "))))

(defun sanityinc/hide-org-clock-from-header-line ()
  (setq-default header-line-format nil))

(add-hook 'org-clock-in-hook 'sanityinc/show-org-clock-in-header-line)
(add-hook 'org-clock-out-hook 'sanityinc/hide-org-clock-from-header-line)
(add-hook 'org-clock-cancel-hook 'sanityinc/hide-org-clock-from-header-line)

(after-load 'org-clock
  (define-key org-clock-mode-line-map [header-line mouse-2] 'org-clock-goto)
  (define-key org-clock-mode-line-map [header-line mouse-1] 'org-clock-menu))

(require-package 'calfw)
(require 'calfw-org)

(after-load 'org
  (define-key org-mode-map (kbd "C-M-<up>") 'org-up-element)
  (when *is-a-mac*
    (define-key org-mode-map (kbd "M-h") nil))
  (define-key org-mode-map (kbd "C-M-<up>") 'org-up-element)
  (when *is-a-mac*
    (autoload 'omlg-grab-link "org-mac-link")
    (define-key org-mode-map (kbd "C-c g") 'omlg-grab-link)))


;; Remove empty LOGBOOK drawers on clock out
(defun remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "LOGBOOK" (point))))

(add-hook 'org-clock-out-hook 'remove-empty-drawer-on-clock-out 'append)

(provide 'init-org)
