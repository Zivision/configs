(defvar project-root
  (file-name-directory
   (directory-file-name
    (file-name-directory
     (file-truename (or load-file-name buffer-file-name))))))

(defun hypr/launch-vterm
    ()
  "Open a new frame with a vterm buffer."
  (+vterm/here 0)
  (switch-to-buffer "*vterm*"))

(defun hypr/launch-eshell
    ()
  "Open a new eshell frame if one doesn't exist. Otherwise open new eshell buffer."
  (if (get-buffer "*doom:eshell*")
      (switch-to-buffer "*doom:eshell*")
    (progn
      (+eshell/here 0)
      (switch-to-buffer "*doom:eshell*")
      (eshell/clear))))

(defun hypr/launch-elfeed
    ()
  (elfeed)
  (elfeed-update)
  (switch-to-buffer "*elfeed-search*"))

(defun hypr/launch-scratch
    ()
  (scratch-buffer)
  (switch-to-buffer "*scratch*"))

(setq fancy-splash-image "~/Pictures/wallpapers/Pics/Emacs-logo.svg.png")

(map!
 :prefix "C-c o f"
 :desc "Open notes.org" "n" #'(lambda ()
                                (interactive)
                                (find-file
                                 (concat org-directory "/notes.org")))
 :desc "Open config.org" "c" #'(lambda ()
                                 (interactive)
                                 (find-file
                                  (concat project-root "config.org"))))

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

(map!
 :prefix "C-c r"
 :desc "Run application" "r" #'xdg-launcher-run-app)

(global-set-key (kbd "<C-up>"   ) 'shrink-window)
(global-set-key (kbd "<C-down>" ) 'enlarge-window)
(global-set-key (kbd "<C-left>" ) 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)

(add-hook 'org-mode-hook
          (lambda () (text-scale-set 1))) ; Make font larger in org mode

(add-hook 'prog-mode-hook
          (lambda () (text-scale-set 0))) ; Reset font for programming modes

(setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :size 16))
(setq doom-serif-font (font-spec :family "DejaVu Serif" :size 16))

;; Make doom large font even bigger
(setq doom-big-font-increment 6)

;; Enable bold and italic for better syntax highlighting
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (setq doom-miramare-brighter-comments t))

;; Set Theme
(setq doom-theme 'doom-miramare)

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

(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))

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
             (propertize (format "[%s@EMACS]" user)
                         'face 'font-lock-keyword-face)
             " |> "
             (propertize pwd 'face 'font-lock-string-face)
             git-part
             "\n"
             ;; Second line
             (propertize emacs 'face 'font-lock-comment-face)
             "\n"
             (propertize time 'face 'font-lock-comment-face)
             " "
             (propertize "λ "
                         'face 'font-lock-function-name-face)))))

  (setq eshell-prompt-regexp "^[^λ]*λ "))



(setq emms-source-file-default-directory "~/Music/")

(after! elfeed
  (setq rmh-elfeed-org-files (list "~/Documents/org/elfeed.org")))

(use-package! nerd-icons-completion
  :config
  (nerd-icons-completion-mode))
(use-package! nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

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

(map! :after elpher
      :map elpher-mode-map
      "-" #'elpher-back)

;; Always create projects when switching projects
(setq +workspaces-on-switch-project-behavior t)

(after! org
  (setq org-agenda-files '("~/Documents/org/agenda/agenda.org"))
  (setq org-directory "~/Documents/org")
  (setq org-roam-directory "~/Documents/org/roam")
  (setq org-hide-emphasis-markers t))

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
