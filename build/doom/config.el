(defvar project-root "~/Workspace/Misc/configs")

(after! doom
  (add-to-list 'load-path (expand-file-name "build/doom/elisp" project-root)))


(after! auth-source
  (setq auth-sources '("~/Private/.authinfo.gpg")))

(defun wm/launch-eshell
    ()
  "Open a new eshell frame if one doesn't exist. Otherwise open new eshell buffer."
  (if (get-buffer "*doom:eshell*")
      (switch-to-buffer "*doom:eshell*")
    (progn
      (+eshell/here 0)
      (switch-to-buffer "*doom:eshell*")
      (eshell/clear))))

(require 'tangle-configs)

(setq fancy-splash-image "~/Pictures/wallpapers/Pics/Emacs-logo.svg.png")

(map!
 :prefix "C-c o d"
 :desc "Open org directory" "o" #'(lambda ()
                                (interactive)
                                (dired org-directory ))
 :desc "Open configs directory" "c" #'(lambda ()
                                 (interactive)
                                 (dired project-root)))

(map!
 :prefix "C-c m"
 :desc "Open EMMS" "e" #'emms
 :desc "Pause EMMS" "t" #'emms-pause
 :desc "Refresh EMMS" "R" #'(lambda ()
                              (interactive)
                              (emms-add-directory "~/Music")
                              (emms))
 :desc "Seek forward" "l" #'emms-seek-forward
 :desc "Seek backwards" "h" #'emms-seek-backward
 :desc "Next Track" "j" #'emms-next
 :desc "Previous track" "k" #'emms-previous)

(map!
 :prefix "C-c n"
 :desc "Open elfeed" "f" #'elfeed
 :desc "Unjam elfeed" "u" #'elfeed-unjam
 :desc "Update elfeed" "U" #'elfeed-update)

(global-set-key (kbd "<C-up>"   ) 'shrink-window)
(global-set-key (kbd "<C-down>" ) 'enlarge-window)
(global-set-key (kbd "<C-left>" ) 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)

(add-hook 'org-mode-hook
          (lambda () (text-scale-set 1))) ; Make font larger in org mode

(add-hook 'prog-mode-hook
          (lambda () (text-scale-set 0))) ; Reset font for programming modes

(setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :size 16)
      doom-serif-font (font-spec :family "DejaVu Serif" :size 16))

;; Make doom large font even bigger
(setq doom-big-font-increment 4)

;; Enable bold and italic for better syntax highlighting
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (doom-themes-visual-bell-config)
  (setq doom-monokai-classic-brighter-comments t))

;; Set Theme
(setq doom-theme 'doom-monokai-classic)

;; Remove all window borders and dividers
(setq window-divider-default-bottom-width 0
      window-divider-default-right-width 0
      window-divider-default-places nil)
(window-divider-mode -1)

;; Make borders invisible by matching background
(set-face-background 'vertical-border "#000000")
(set-face-foreground 'vertical-border "#000000")

;; Remove fringe (the side margins)
(set-fringe-mode 0)  ; Or use a number like 8 for minimal fringe

;; Optional: make internal borders match your background
(custom-set-faces!
  '(vertical-border :foreground "#000000" :background "#000000")
  '(window-divider :foreground "#000000")
  '(window-divider-first-pixel :foreground "#000000")
  '(window-divider-last-pixel :foreground "#000000"))

(setq display-line-numbers-type `relative)

(after! doom-modeline
  ;; Configuration
  (setq doom-modeline-height 40
        doom-modeline-bar-width 6
        doom-modeline-icon t
        doom-modeline-major-mode-icon t
        doom-modeline-major-mode-color-icon t
        doom-modeline-buffer-file-name-style 'truncate-upto-project
        doom-modeline-buffer-encoding t
        doom-modeline-indent-info t
        doom-modeline-lsp t
        doom-modeline-env-version t
        doom-modeline-enable-word-count nil
        doom-modeline-column-zero-based nil
        doom-modeline-minor-modes nil))


(display-time-mode 1)

(add-to-list 'auto-mode-alist '("\\.astro\\'" . web-mode))

(setq package-review-policy t
      package-review-diff-command '("git" "diff" "--no-index" "--color=never" "--diff-filter=d"))

(after! eshell
  (require 'magit)

  (setq eshell-prompt-function
        (lambda ()
          (let* ((user (user-login-name))
                 (emacs (format "GNU EMACS-%s" emacs-version))
                 (pwd  (abbreviate-file-name (eshell/pwd)))
                 (branch (ignore-errors (magit-get-current-branch)))
                 ;; 12-hour time with AM/PM
                 (time (format-time-string "%I:%M %p"))
                 ;; Nerd Font Git branch icon (nf-dev-git_branch)
                 (git-icon "")
                 (git-part (when branch
                             (concat
                              " "
                              (propertize git-icon
                                          'face 'font-lock-constant-face)
                              " "
                              (propertize branch
                                          'face 'font-lock-constant-face)))))
            (concat
             ;; First line
             (propertize (format "[%s@%s]" user emacs)
                         'face 'font-lock-keyword-face)
             " >>> "
             (propertize pwd 'face 'font-lock-string-face)
             git-part
             ;; Second line
             "\n"
             (propertize time 'face 'font-lock-comment-face)
             " "
             (propertize "λ "
                         'face 'font-lock-function-name-face)))))

  (setq eshell-prompt-regexp "^[^λ]*λ "))



;; For auth in mini buffer
(setq epg-pinentry-mode 'loopback)

(use-package! gptel
  :config
  (defun my/gptel-get-key (host)
    (auth-source-pick-first-password :host host :user "apikey"))
  (setq gptel-backend
        (gptel-make-gemini "Gemini"
          :stream t
          :key (lambda () (my/gptel-get-key "generativelanguage.googleapis.com"))))
  (setq gptel-model 'gemini-3-flash-preview))

(after! EMMS
  (require 'emms-source-file)
  (emms-all)

  (setq-default emms-source-file-default-directory "~/Music/"))

(after! elfeed
  (setq rmh-elfeed-org-files (list "~/Documents/org/elfeed.org")))

(use-package! elfeed-tube
  :ensure t ;; or :straight t
  :after elfeed
  :demand t
  :config
  ;; (setq elfeed-tube-auto-save-p nil) ; default value
  ;; (setq elfeed-tube-auto-fetch-p t)  ; default value
  (setq elfeed-tube-backend 'yt-dlp)
  (elfeed-tube-setup))

(use-package! elfeed-tube-mpv
  :ensure t) ;; or :straight t

;; Load after vertico
(after! vertico
  (use-package! nerd-icons-completion
    :config
    (nerd-icons-completion-mode)))


(use-package! nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package! golden-ratio
    :config
  (golden-ratio-mode t)
  (setq golden-ratio-extra-commands
        (append golden-ratio-extra-commands
                '(evil-window-left
                  evil-window-right
                  evil-window-up
                  evil-window-down
                  next-multiframe-window
                  previous-multiframe-window))))

(use-package! beacon
  :config
  (setq beacon-size 30
        beacon-color "#F92660"
        beacon-blink-duration 0.9
        beacon-blink-delay 0.0)
  (beacon-mode 1))

(after! dap-mode
  (setq dap-auto-configure-features '(sessions locals controls tooltip))
  (dap-mode 1)
  (dap-ui-mode 1)

(require 'dap-python)
;; Set python debugger (debugpy)
(setq dap-python-debugger 'debugpy)

(require 'dap-node)
;; Auto-installs debug adapter
(dap-node-setup)

(require 'dap-dlv-go))

(after! org
  (setq org-directory "~/Documents/org")
  (setq org-agenda-files
        `(,(expand-file-name "agenda/agenda.org" org-directory)
          ,(expand-file-name "todo.org" org-directory)))
  (setq org-roam-directory "~/Documents/org/roam")
  (setq org-hide-emphasis-markers t)
  (setq org-default-notes-file (expand-file-name "notes.org" org-directory)))

(after! org
  (setq org-capture-templates
        `(("t" "Personal todo" ; Todo items
          entry (file+headline +org-capture-todo-file " Capture Tasks")
          ,(concat
           "* TODO [#B] [ ] %? "
           (format-time-string "<%Y-%m-%d %a>"
                               (org-read-date nil t "Fri"))
           "\n\n%a")
          :prepend t)


         ;; Notes
         ("n" "Personal notes"
          entry (file+headline +org-capture-notes-file "Capture Notes")
          "* %u %?\n%i\n%a" :prepend t)


         ("j" "Journal"
          entry (file+olp+datetree +org-capture-journal-file)
          "* %U %?\n%i\n%a" :prepend t)
         ("p" "Templates for projects")
         ("pt" "Project-local todo" entry
          (file+headline +org-capture-project-todo-file "Inbox") "* TODO %?\n%i\n%a"
          :prepend t)
         ("pn" "Project-local notes" entry
          (file+headline +org-capture-project-notes-file "Inbox") "* %U %?\n%i\n%a"
          :prepend t)
         ("pc" "Project-local changelog" entry
          (file+headline +org-capture-project-changelog-file "Unreleased")
          "* %U %?\n%i\n%a" :prepend t)
         ("o" "Centralized templates for projects")
         ("ot" "Project todo" entry #'+org-capture-central-project-todo-file
          "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
         ("on" "Project notes" entry #'+org-capture-central-project-notes-file
          "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
         ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file
          "* %U %?\n %i\n %a" :heading "Changelog" :prepend t))))

(after! org
  ;; Show upcoming holidays
  (setq org-agenda-include-diary t))

;; Org modern settings
(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  ;; Basic settings
  (setq org-modern-star '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶")
        org-modern-table-vertical 1
        org-modern-table-horizontal 0.2
        org-modern-list '((43 . "➤") (45 . "–") (42 . "•"))
        org-modern-block-fringe nil
        org-modern-todo-faces
        '(("TODO"  :foreground "red")
          ("DONE"  :foreground "green")
          ("IDEA"  :foreground "yellow")
          ("PROJ"  :foreground "magenta")))

  ;; Source code block settings
  (setq org-src-fontify-natively t      ; Syntax highlight in code blocks
        org-src-tab-acts-natively t      ; Tab works normally in code blocks
        org-src-preserve-indentation t))  ; Preserve indentation

(use-package! org-appear
  :after org-modern
  :hook (org-mode . org-appear-mode))

(setq-default org-download-image-dir "~/Pictures/Org")

(after! org
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?" :target
           (file+head
            "%<%Y%m%d%H%M%S>-${slug}.org"
            "#+title: ${title}\nHead to the [[id:6c8c0623-2b7f-4717-9985-2733777df46e][Home-Node]]\n")
           :unnarrowed t))))

(use-package! toc-org
  :hook (org-mode . toc-org-mode))

(use-package! olivetti
  :hook (org-mode . olivetti-mode)
  :init (setq olivetti-body-width 100))

(after! org
  (setq org-babel-python-command "python3") ; Sets python to "python3"
  (setq org-babel-default-header-args:python '((:results . "output")))) ; Sets results to output

(after! org
  ;; Disables these modes that freeze org mode
  (global-prettify-symbols-mode -1)
  (global-prettify-symbols-mode -1))
