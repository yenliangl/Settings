;; ----------------------------------------------------------------------
;; Settings for org-mode
;; ----------------------------------------------------------------------

(require 'org-install)
;;(require 'org-screen)
;;(require 'org-expiry)

;; (make-face 'my-org-fontlock-face)
;; (set-face-attribute 'my-org-fontlock-face nil :family "Monaco" )
(add-hook 'org-mode-hook
          (lambda()
            (font-lock-mode t)
            ;; (buffer-face-mode t)
            ;; (buffer-face-set 'my-org-fontlock-face)
            (imenu-add-to-menubar "Imenu")

            ;; yasnippet
            ;; (make-variable-buffer-local 'yas/trigger-key)
            ;; (setq yas/trigger-key [tab])
            ;; (define-key yas/keymap [tab] 'yas/next-field-group)

            (make-local-variable 'fill-column)
            (setq fill-column 70)

            ;; flyspell mode
            (flyspell-mode 1)))

(if (boundp 'ORG_HOME)
    (setq org-directory ORG_HOME)
  (setq org-directory (expand-file-name "~/Work/Org")))

(if (boundp 'ORG_HOME_AT_WORK)
    (setq org-internal-directory ORG_HOME_AT_WORK)
  (setq org-internal-directory (expand-file-name "~/Org")))

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-completion-use-ido t)
(setq org-support-shift-select t)
;; STARTED = ACTION
;; DONE = FINISHED

;; The "|" separates the TODO keywords (states that need action) from the DONE
;; states (which need no further action).
;; @: log a note with timestamp
;; !: log a timestamp
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s!)" "NEXT(n!)" "WAITING(w@)" "SOMEDAY(o!)" "MAYBE(m@/!)" "|" "CANCELLED(c@/!)" "DONE(d@/!)")
        (sequence "BUG(b)" "ASSIGNED(a!)" "|" "REJECTED(j@/!)" "CLOSED(C@/!)" "FIXED(x@)")
        ))
;; Another use model of TODO work flow.
;; (setq org-todo-keywords '((type "Fred" "Sara" "Lucy" "|" "DONE")))

(setq org-use-fast-todo-selection t)
(setq org-enforce-todo-dependencies t)  ;

;; --------------------------------------------------
;; Automatically change list bullets
;; --------------------------------------------------
;; | Curent list bullet | next indented list bullet |
;; | +                  | -                         |
;; | *                  | -                         |
;; | 1.                 | -                         |
;; | 1)                 | -                        |
(setq org-list-demote-modify-bullet
      (quote (("+" . "-")
              ("*" . "-")
              ("1." . "-")
              ("1)" . "-"))))

;; ----------------------------------------------------------------------
;; capture/refile/archive flow
;; ----------------------------------------------------------------------
;; ------------------------------ capture ---------------------------------------
(setq org-default-notes-file (concat org-directory "/REFILE.org"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      `(("t" "Task" entry (file+headline (concat org-directory "/REFILE.org") "Task") "* TODO %^{Task title} %^g\n  %?\n  %i\n  %U\n  %a\n" :prepend t)
        ("n" "Note" entry (file+headline (concat org-directory "/REFILE.org") "Note") "* %^{Note title} %^g\n  %?\n  %i\n  %u\n  %a\n" :prepend t)
        ("v" "Vocabulary" entry (file+headline (concat org-directory "/english/english.org") "Vocabulary") "* %^{Word}\n  %?\n  %i\n  %u\n" :prepend t)
        ("p" "Phrase" entry (file+headline (concat org-directory "/english/english.org") "Phrase") "* %^{Phrase}\n  %?\n  %i\n  %u\n" :prepend t)
        ;;("j" "Journal" item (file+function (concat org-directory "/journal/my_2012.org") org-journal-find-entry-location-p) "* %?\nEntered on %U\n  %i\n   %a" :prepend t)
        ("q" "Next task for today" entry (file+headline (concat org-directory "/REFILE.org") "Task") "* NEXT %^{Task title}\n  SCHEDULED: %T" :immediate-finish t)))

;; refile
(setq org-completion-use-ido t)

; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))
; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path (quote full-file-path))
; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps t)
; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

(setq org-tag-persistent-alist
      '(("Task" . nil)
        ("Note" . nil)

        ;; Month
        ("@January" . nil)
        ("@Feburary" . nil)
        ("@March" . nil)
        ("@April" . nil)
        ("@May" . nil)
        ("@June" . nil)
        ("@July" . nil)
        ("@August" . nil)
        ("@September" . nil)
        ("@October" . nil)
        ("@November" . nil)
        ("@December" . nil)

        ;; Study group
        ("Study" . nil)
        (:startgroup . nil)
        ("book" . nil)
        ("paper" . nil)
        ("manual" . nil)
        (:endgroup . nil)

        ;; Location
        ("@India" . nil)
        ("@Taipei" . nil)
        ("@China" . nil)
        ("@Hualien" . nil)
        ("@TPML" . nil)

        ;; Work
        ("Company" . nil)
        (:startgroup . nil)
        ("@alchip" . nil)
        ("@altek" . nil)
        ("@synopsys" . nil)
        (:endgroup . nil)

        ;; Operating systems
        ("Ubuntu" . nil)
        ("Windows" . nil)
        ("MacOSX" . nil)
        ("Unix" . nil)
        ("Android" . nil)
        ("iOS" . nil)

        ;; EDA/VLSI Topics
        ("EDA" . nil)

        ;; Emacs
        ("Emacs" . nil)
        (:startgroup . nil)
        ("org-mode" . nil)
        (:endgroup . nil)

        ;; Emacs
        ("Shell" . nil)
        (:startgroup . nil)
        ("bash" . nil)
        ("tcsh" . nil)
        (:endgroup . nil)

        ("Software" . nil)
        (:startgroup . nil)

        ;; programming language
        ("java" . nil)
        ("cpp" . nil)
        ("tcl" . nil)

        ("synmake" . nil)
        ("gnumake" . nil)
        ("cmake" . nil)
        ("parser" . nil)
        ("designpattern" . nil)
        ("ui" . nil)
        ("font" . nil)
        ("guideline" . nil)
        ("qt" . nil)
        ("performance" . nil)
        ("test" . nil)
        ("debug" . nil)
        ("network" . nil)

        ;; SCM
        ("cvs" . nil)
        ("git" . nil)
        ("subversion" . nil)
        ("perforce" . nil)
        (:endgroup . nil)

        ("Bug" . nil)
        ("Enhancement" . nil)

        ("Presentation" . nil)

        ;;
        ("Personal" . nil)
        ("Shopping" . nil)
        ("Project" . nil)

        ;;
        ("Quote" . nil)
        ("Career" . nil)
        ("Health" . nil)
        ("Exhibition" . nil)
        ("Meeting" . nil)
        ("Conference" . nil)
        ("Seminar" . nil)
        ("Training" . nil)
        ))

(setq org-log-into-drawer "LOGBOOK")
(setq org-log-state-notes-into-drawer "LOGBOOK")
(setq org-clock-persist 'history
      org-clock-persist-file (convert-standard-filename (concat org-directory "/org-clock-save.el"))
      )
(org-clock-persistence-insinuate)

(load-library "find-lisp")
(setq org-agenda-files
      (append (find-lisp-find-files org-directory  "\.org$") (find-lisp-find-files org-internal-directory "\.org$")))

;; Mark a TODO entry DONE automatically when all children are done
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)    ;turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;;
;; org-publish directories
;;
(require 'org-publish)
(setq org-publishing-directory "~/Dropbox/public_html")
(if (and (boundp 'my-org-publish-to-remote) my-org-publish-to-remote)
    (setq org-internal-publishing-directory (concat "/ssh:" user-login-name "@starrc01:~/public_html"))
  (setq org-internal-publishing-directory "~/public_html"))

(setq org-publish-project-alist
      `(                                ;use back-quote
        ;; publish to public cloud
        ("org" :components ("org-notes" "org-css" "org-doc" "org-images"))

        ;; components
        ("org-notes"
         :base-directory ,org-directory
         :base-extension "org"
         :publishing-directory ,org-publishing-directory
         :recursive t
         :publishing-function org-publish-org-to-html
         :plain-source t
         :headline-levels 10
         :htmlized-source t
         :section-numbers nil
         :table-of-contents t
         :style "<link rel=\"stylesheet\" href=\"css/org.css\" type=\"text/css\"/>"
         :auto-preamble t
         :auto-index t
         :auto-sitemap t
         :sitemap-filename "index.html"
         :sitemap-title "Homepage of Liu, Yen-Liang (David)"
         :sitemap-style "tree"
         :sitemap-sort-folders "last"
         :sitemap-sort-files "anti-chronologically"
         :tags nil
         )

        ("org-css"
         :base-directory ,(concat org-directory "/css")
         :base-extension "css\\|js"
         :publishing-directory ,(concat org-publishing-directory "/css")
         :recursive t
         :publishing-function org-publish-attachment
         )

        ("org-doc"
         :base-directory ,(concat org-directory "/doc")
         :publishing-directory ,(concat org-publishing-directory "/doc")
         :base-extension "doc\\|docx\\|ppt\\|pptx\\|pdf"
         :recursive t
         :publishing-function org-publish-attachment
         )

        ("org-images"
         :base-directory ,(concat org-directory "/images")
         :base-extension "png\\|jpg\\|gif"
         :publishing-directory ,(concat org-publishing-directory "/images")
         :recursive t
         :publishing-function org-publish-attachment
         )

        ;; publish to internal cloud
        ("org-internal" :components ("org-internal-notes" "org-internal-css" "org-internal-images"))

        ;; for everythings that should be kept away from public
        ("org-internal-notes"
         :base-directory ,org-internal-directory
         :base-extension "org"
         :publishing-directory ,org-internal-publishing-directory
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 10
         :htmlized-source t
         :section-numbers nil
         :table-of-contents t
         :style "<link rel=\"stylesheet\" href=\"css/org.css\" type=\"text/css\"/>"
         :auto-preamble t
         :auto-index t
         :auto-sitemap t
         :sitemap-filename "index.html"
         :sitemap-title "Homepage of Liu, Yen-Liang (David)"
         :sitemap-style "tree"
         :sitemap-sort-folders "first"
         :sitemap-sort-files "anti-chronologically"
         :tags nil
         )

        ("org-internal-css"
         :base-directory ,(concat org-internal-directory "/css")
         :publishing-directory ,(concat org-internal-publishing-directory "/css")
         :base-extension "css\\|js"
         :recursive t
         :publishing-function org-publish-attachment
         )

        ("org-internal-images"
         :base-directory ,(concat org-internal-directory "/images")
         :base-extension "png\\|jpg\\|gif"
         :publishing-directory ,(concat org-internal-publishing-directory "/images")
         :recursive t
         :publishing-function org-publish-attachment
         )
        ))

;; --------------------------------------------------
;; Agenda view
;; --------------------------------------------------
;; tasks with dates are scheduled into the future sometime and you don't
;; need to deal with them until the date approaches
(setq org-agenda-todo-ignore-with-date t
      org-agenda-skip-deadline-if-done t
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-timestamp-if-done t
      org-agenda-span 'week             ;org-agenda-ndays is obsolete
      org-deadline-warning-days 3
      org-agenda-show-all-dates nil
      ;;       org-remember-store-without-prompt nil
      ;;       remember-annotation-functions (quote (org-remember-annotation))
      ;;       remember-handler-functions (quote (org-remember-handler))
      org-agenda-include-diary t        ;include Emacs diary
      org-use-property-inheritance t
      org-reverse-note-order t
      org-agenda-dim-blocked-tasks t    ;dim blocked tasks
      org-agenda-compact-blocks t       ;compact the block agenda view
      )

;; -----------------------------------
;; Copied from http://doc.norang.ca/org-mode.html#sec-4-4
;; -----------------------------------
;; (setq org-agenda-custom-commands
;;       (quote (("N" "Notes" tags "NOTE"
;;                ((org-agenda-overriding-header "Notes")
;;                 (org-tags-match-list-sublevels t)))
;;               ("h" "Habits" tags-todo "STYLE=\"habit\""
;;                ((org-agenda-overriding-header "Habits")
;;                 (org-agenda-sorting-strategy
;;                  '(todo-state-down effort-up category-keep))))
;;               (" " "Agenda"
;;                ((agenda "" nil)
;;                 (tags "REFILE"
;;                       ((org-agenda-overriding-header "Tasks to Refile")
;;                        (org-tags-match-list-sublevels nil)))
;;                 (tags-todo "-CANCELLED/!"
;;                            ((org-agenda-overriding-header "Stuck Projects")
;;                             (org-agenda-skip-function 'bh/skip-non-stuck-projects)))
;;                 (tags-todo "-WAITING-CANCELLED/!NEXT"
;;                            ((org-agenda-overriding-header "Next Tasks")
;;                             (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
;;                             (org-agenda-todo-ignore-scheduled t)
;;                             (org-agenda-todo-ignore-deadlines t)
;;                             (org-agenda-todo-ignore-with-date t)
;;                             (org-tags-match-list-sublevels t)
;;                             (org-agenda-sorting-strategy
;;                              '(todo-state-down effort-up category-keep))))
;;                 (tags-todo "-REFILE-CANCELLED/!-SOMEDAY-WAITING"
;;                            ((org-agenda-overriding-header "Tasks")
;;                             (org-agenda-skip-function 'bh/skip-project-tasks-maybe)
;;                             (org-agenda-todo-ignore-scheduled t)
;;                             (org-agenda-todo-ignore-deadlines t)
;;                             (org-agenda-todo-ignore-with-date t)
;;                             (org-agenda-sorting-strategy
;;                              '(category-keep))))
;;                 (tags-todo "-SOMEDAY-CANCELLED/!"
;;                            ((org-agenda-overriding-header "Projects")
;;                             (org-agenda-skip-function 'bh/skip-non-projects)
;;                             (org-agenda-sorting-strategy
;;                              '(category-keep))))
;;                 (tags-todo "-CANCELLED/!WAITING|SOMEDAY"
;;                            ((org-agenda-overriding-header "Waiting and Postponed Tasks")
;;                             (org-agenda-skip-function 'bh/skip-stuck-projects)
;;                             (org-tags-match-list-sublevels nil)
;;                             (org-agenda-todo-ignore-scheduled 'future)
;;                             (org-agenda-todo-ignore-deadlines 'future)))
;;                 (tags "-REFILE/"
;;                       ((org-agenda-overriding-header "Tasks to Archive")
;;                        (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
;;                        (org-tags-match-list-sublevels nil))))
;;                nil)
;;               ("r" "Tasks to Refile" tags "REFILE"
;;                ((org-agenda-overriding-header "Tasks to Refile")
;;                 (org-tags-match-list-sublevels nil)))
;;               ("#" "Stuck Projects" tags-todo "-CANCELLED/!"
;;                ((org-agenda-overriding-header "Stuck Projects")
;;                 (org-agenda-skip-function 'bh/skip-non-stuck-projects)))
;;               ("n" "Next Tasks" tags-todo "-WAITING-CANCELLED/!NEXT"
;;                ((org-agenda-overriding-header "Next Tasks")
;;                 (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
;;                 (org-agenda-todo-ignore-scheduled t)
;;                 (org-agenda-todo-ignore-deadlines t)
;;                 (org-agenda-todo-ignore-with-date t)
;;                 (org-tags-match-list-sublevels t)
;;                 (org-agenda-sorting-strategy
;;                  '(todo-state-down effort-up category-keep))))
;;               ("R" "Tasks" tags-todo "-REFILE-CANCELLED/!-SOMEDAY-WAITING"
;;                ((org-agenda-overriding-header "Tasks")
;;                 (org-agenda-skip-function 'bh/skip-project-tasks-maybe)
;;                 (org-agenda-sorting-strategy
;;                  '(category-keep))))
;;               ("p" "Projects" tags-todo "-SOMEDAY-CANCELLED/!"
;;                ((org-agenda-overriding-header "Projects")
;;                 (org-agenda-skip-function 'bh/skip-non-projects)
;;                 (org-agenda-sorting-strategy
;;                  '(category-keep))))
;;               ("w" "Waiting Tasks" tags-todo "-CANCELLED/!WAITING|SOMEDAY"
;;                ((org-agenda-overriding-header "Waiting and Postponed tasks"))
;;                (org-tags-match-list-sublevels nil))
;;               ("A" "Tasks to Archive" tags "-REFILE/"
;;                ((org-agenda-overriding-header "Tasks to Archive")
;;                 (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
;;                 (org-tags-match-list-sublevels nil))))))

(setq org-agenda-custom-commands
      '(("G" "2012 Goal"
         ((tags-todo "+@2012+GOAL-DONE"))
         ((org-agenda-overriding-header "2012 Goals: ")
          (org-agenda-show-log t)
          (org-agenda-log-mode-items '(state))
          (org-agenda-compact-blocks t)
          (org-agenda-skip-function '(org-agenda-skip-entry-if 'regexp "[/]")))
         )

        ("D" "Daily Habits"
         ((agenda "" ((org-agenda-span 3)))
          (tags-todo "+STYLE=\"habit\"")
          ;(tags "Daily")
          )
         ((org-agenda-overriding-header "Daily habit: ")
          (org-agenda-show-log t)
          (org-agenda-log-mode-items '(state))
          (org-agenda-compact-blocks t))
         ;; (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp ":Daily:"))))
         )

        ;; ("W" "Weekly Habits"
        ;;  ((agenda "")
        ;;   (tags "Habit"))

        ;;  ((org-agenda-show-log t)
        ;;   (org-agenda-span 7)
        ;;   (org-agenda-log-mode-items '(state))
        ;;   (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp ":Weekly:"))))

        ;; ("M" "Monthly Habits"
        ;;  ((agenda "")
        ;;   (tags "Habit"))
        ;;  ((org-agenda-show-log t)
        ;;   (org-agenda-span 7)
        ;;   (org-agenda-log-mode-items '(state))
        ;;   (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp ":Monthly:")))
        ;;  )
        ))

(setq org-agenda-diary-file (concat org-directory "/diary.org")) ;; change this

(defadvice org-agenda-add-entry-to-org-agenda-diary-file
  (after add-to-google-calendar)
  "Add a new Google calendar entry that mirrors the diary entry just created by
org-mode."
  (let ((type (ad-get-arg 0))
        (text (ad-get-arg 1))
        (d1 (ad-get-arg 2))
        (year1 (nth 2 d1))
        (month1 (car d1))
        (day1 (nth 1 d1))
        (d2 (ad-get-arg 3))
        entry dates)
    (if (or (not (eq type 'block)) (not d2))
        (setq dates (format "%d-%02d-%02d" year1 month1 day1))
      (let ((year2 (nth 2 d2)) (month2 (car d2)) (day2 (nth 1 d2)) (repeats (-
                                                                             (calendar-absolute-from-gregorian d1)
                                                                             (calendar-absolute-from-gregorian d2))))
        (if (> repeats 0)
            (setq dates (format "%d-%02d-%02d every day for %d days" year1
                                month1 day1 (abs repeats)))
          (setq dates (format "%d-%02d-%02d every day for %d days" year1 month1
                              day1 (abs repeats))))
        ))
    (setq entry (format "/usr/bin/google calendar add --cal org \'%s %s\'"
                        text dates))
    ;;(message entry)
    (if (not (string= "offline" mail-host-address))
        (shell-command entry)
      (let ((offline "~/tmp/org2google-offline-entries"))
        (find-file offline)
        (goto-char (point-max))
        (insert (concat entry "\n"))
        (save-buffer)
        (kill-buffer (current-buffer))
        (message "Plain text written to %s" offline)))))
(ad-activate 'org-agenda-add-entry-to-org-agenda-diary-file)

;; (require 'org-latex)

(setq org-clock-persist t)
(org-clock-persistence-insinuate)
(setq org-clock-history-length 35)
(setq org-clock-in-resume t)
(setq org-clock-in-switch-to-state "STARTED")
(setq org-clock-into-drawer t)
(setq org-clock-out-remove-zero-time-clocks t)
(setq org-clock-out-when-done t)
(setq org-export-html-inline-images t)

;; Include agenda archive file when searching for things
(setq org-agenda-text-search-extra-files (quote (agenda-archives)))

;; activate highlight-line-mode for aganda view
(add-hook 'org-agenda-mode-hook
          '(lambda ()
             (hl-line-mode 1)))

;; show all future entries for repeating tasks
(setq org-agenda-repeating-timestamp-show-all t)
(setq org-agenda-show-all-dates t)

;; sorting order for tasks on the agenda
(setq org-agenda-sorting-strategy
      (quote ((agenda time-up priority-down effort-up category-up)
              (todo priority-down)
              (tags priority-down))))

;; start the weekly agenda today
(setq org-agenda-start-on-weekday nil)

;; customize display of the time grid
;; (setq org-agenda-time-grid
;;       (quote (nil "-------------------------------------"
;;                   (800 1000 1200 1400 1600 1800 2000))))

(defun my-org-agenda-to-appt ()
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt))
(add-hook 'org-finalize-agenda-hook 'my-org-agenda-to-appt)
(run-at-time "24:01" nil 'my-org-agenda-to-appt)

(my-org-agenda-to-appt)
(run-at-time "00:59" 3600 'org-save-all-org-buffers) ; save all org-buffers at 1 minute before the hour

;; --------------------------------------------------
;; w3m
;; --------------------------------------------------
;;(require 'org-w3m)
;;(require 'org-wl)

;; invoice support
(autoload 'org-invoice-report "org-invoice")
(autoload 'org-dblock-write:invoice "org-invoice")

(require 'org-habit)

;; encryption
(require 'org-crypt)
(org-crypt-use-before-save-magic) ; Encrypt all entries before saving
(setq org-tags-exclude-from-inheritance (quote ("crypt"))) ; Which tag is used to mark headings to be encrypted
(setq org-crypt-key "0C6F5345") ;; yenliangl@gmail.com

;; unique id for every task
(require 'org-id)
(setq org-id-method (quote uuidgen))
;; (add-hook 'org-insert-heading-hook
;;           (lambda () (org-id-get-create))) ;; always add ID for a header section

;; --------------------------------------------------
;; Attachments
;; --------------------------------------------------
(setq org-attach-directory (expand-file-name (concat DROPBOX "/Data")))
(cond ((eq system-type 'cygwin) (setq org-attach-open "cygstart %s"))
      ((eq system-type 'darwin) (setq org-attach-open "open %s"))
      (t (setq org-attach-open "gnome-open")))
(setq org-file-apps
      `((auto-mode . emacs) ("\\.*\\'" . ,org-attach-open)))

;; --------------------------------------------------
;; babel
;; --------------------------------------------------
(defconst my-org-ditaa-jar-path (concat ORG_LISP_HOME "/contrib/scripts/ditaa.jar"))
(if (eq system-type 'cygwin)
    (setq org-ditaa-jar-path (replace-regexp-in-string "\n" "" (shell-command-to-string (concat "cygpath -w " my-org-ditaa-jar-path))))
  (setq org-ditaa-jar-path my-org-ditaa-jar-path))
;;(setq org-plantuml-jar-path "~/java/plantuml.jar")
;;(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
(setq org-startup-with-inline-images nil)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (ditaa . t)
   (dot . t)
   (emacs-lisp . t)
   (gnuplot . t)
   (haskell . nil)
   (latex . t)
   (ledger . t)         ;this is the important one for this tutorial
   (ocaml . nil)
   (octave . t)
   (python . t)
   (ruby . t)
   (screen . nil)
   (sh . t)
   (sql . nil)
   (sqlite . t)))

(defun org-journal-find-entry-location-p ()
  "Create a new diary entry for today or append to an existing one."
  (interactive)
  (widen)
  (let ((today (format-time-string "%Y/%m/%d %a")))
    (org-goto-local-search-headings today nil t)
    ))

(defun org-journal-insert-today-heading ()
  "Create a new diary entry for today or append to an existing one."
  (interactive)
  (widen)
  (let ((today (format-time-string "%Y-%m-%d %a")))
    ;; (beginning-of-buffer)
    (unless (org-goto-local-search-headings today nil t)
      ((lambda ()
         (org-insert-subheading 2)
         ;; (org-insert-heading 2)
         (insert today)
         ;; insert a item '-' for user to get started journaling
         (insert "\n   - "))))))

(defun org-journal-insert-month-heading ()
  "Create a new diary entry for today or append to an existing one."
  (interactive)
  (widen)
  (let ((month (format-time-string "%Y-%m ")))
    ;; (beginning-of-buffer)
    (unless (org-goto-local-search-headings month nil t)
      ((lambda ()
         (org-insert-heading)
         (insert month)
         (insert (concat ":@" (format-time-string "%B") ":"))
         (insert "\n")
         (org-align-all-tags)
         ;; insert first day journal heading
         (org-journal-insert-today-heading)
         )))))

;; (setq org-startup-indented nil)

;; fontify source block
(setq org-src-fontify-natively t)

;; Use htmlize. Be sure to check if it uses the latest version

(require 'htmlize)
(setq htmlize-output-type 'css
      htmlize-html-charset "utf-8"
      htmlize-convert-nonascii-to-entities nil)

(setq org-infojs-options
      '((path . "~/scripts/org-info.js")
        (view . "info")
        (view . "info")
        (toc . :table-of-contents)
        (ftoc . "0")
        (tdepth . "max")
        (sdepth . "max")
        (mouse . "underline")
        (buttons . "0")
        (ltoc . "1")
        (up . :link-up)
        (home . :link-home)))

;; link abbreviations
(setq org-link-abbrev-alist
      '(("bugzilla"    . "http://10.1.2.9/bugzilla/show_bug.cgi?id=")
        ("google-play" . "https://play.google.com/store/apps/details?id=")
        ("gmap"        . "http://maps.google.com/maps?q=%s")
        ("omap"        . "http://nominatim.openstreetmap.org/search?q=%s&polygon=1")
        ("ads"         . "http://adsabs.harvard.edu/cgi-bin/nph-abs_connect?author=%s&db_key=AST")))

;; --------------------------------------------------
;; mobile-org
;; --------------------------------------------------
;; (setq org-mobile-directory (concat org-directory "/MobileOrg"))
;; (setq org-mobile-directory org-directory)
;; (setq org-mobile-inbox-for-pull (concat org-directory "/TASK.org"))
;; (setq org-mobile-files

;; --------------------------------------------------
;; my feed to track
;; --------------------------------------------------
(require 'org-feed)
(setq org-feed-alist
      '(
        ;; ("TV Series - Falling Skies Season 2"
        ;;  "http://www.ezrss.it/search/index.php?simple&show_name=falling+skies&mode=rss"
        ;;  "~/Dropbox/Org/todo.org"
        ;;  "Falling Skies Season 2"
        ;;  :template "* TODO %title\n  %a\n "
        ;;  )

        ("Android Developer Blog"
         "http://android-developers.blogspot.com/atom.xml"
         "~/Dropbox/Org/android/android.org"
         "Android Developer Blog"
         :template "* TODO %h\n  %T\n"
         )

        ("ESL Podcast"
         "http://feeds.feedburner.com/EnglishAsASecondLanguagePodcast"
         "~/Dropbox/Org/english/english.org"
         "ESL Podcast"
         :template "* TODO %h\n  SCHEDULED: %T\n"
         )

        ("CNN Talk Asia"
         "http://rss.cnn.com/services/podcasting/talkasia/rss"
         "~/Dropbox/Org/english/english.org"
         "CNN Talk Asia"
         :template "* TODO %h\n  SCHEDULED: %T\n"
         )

        ;; TV Shows I am watching
        ("Fringe"
         "http://showrss.karmorra.info/feeds/28.rss"
         "~/Dropbox/Org/todo.org"
         "Fringe"
         :template "* TODO %h\n  SCHEDULED: %T\n"
         :filter my-only-720p-feed-filter
         )

        ("Continuum"
         "http://showrss.karmorra.info/feeds/446.rss"
         "~/Dropbox/Org/todo.org"
         "Continuum"
         :template "* TODO %h\n  SCHEDULED: %T\n"
         :filter my-only-720p-feed-filter
         )

        ("The Big Bang Theory"
         "http://showrss.karmorra.info/feeds/5.rss"
         "~/Dropbox/Org/todo.org"
         "The Big Bang Theory"
         :template "* TODO %h\n  SCHEDULED: %T\n"
         ;; :filter my-only-720p-feed-filter
         )

        ("Falling Skies"
         "http://showrss.karmorra.info/feeds/351.rss"
         "~/Dropbox/Org/todo.org"
         "Falling Skies"
         :template "* TODO %h\n  SCHEDULED: %T\n"
         :filter my-only-720p-feed-filter
         )
        ))

(defun my-only-720p-feed-filter (e)
  (if (string-match "HD 720p" (plist-get e :title))
    e
    nil))

;;* rtm feed timer
(run-at-time 3600 3600 'org-feed-update-all)
