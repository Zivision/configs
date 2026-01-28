(defun scripts/update
    ()
  "Run update script."
  (interactive)
(let ((default-directory (concat "/sudo::" (expand-file-name "~/.local/bin/"))))
    (async-shell-command "./update-all-packages")))

(defun scripts/config
    ()
  "Run config script."
  (interactive)
  (shell-command "stow-configs")
  (message "Done!"))

(map!
 "C-c f c" #'scripts/config
 "C-c f u" #'scripts/update)

(map!
 "C-c d d" #'dirvish
 "C-c d q" #'dirvish-quit
 "C-c d f" #'dirvish-fd)

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
        doom-themes-enable-italic t))

;; Set Theme
(setq doom-theme 'doom-molokai)

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
(display-battery-mode 1)

(add-to-list 'auto-mode-alist '("\\.astro\\'" . web-mode))

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

(use-package! prism
  :init
  (setq prism-desaturations '(10 15 20))
  :hook (((clojure-mode
           emacs-lisp-mode
           lisp-mode
           scheme-mode) . prism-mode)))

(setq org-directory "~/Documents/org")
(after! org
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
        '(("TODO" :background "red" :foreground "white")
          ("DONE" :background "green" :foreground "white")))

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
  :config (setq olivetti-body-width 100))

(after! org
  (setq org-babel-python-command "python3") ; Sets python to "python3"
  (setq org-babel-default-header-args:python '((:results . "output")))) ; Sets results to output

(after! org
  ;; Disables these modes that freeze org mode
  (global-prettify-symbols-mode -1)
  (global-prettify-symbols-mode -1))
