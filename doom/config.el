(add-hook 'org-mode-hook
          (lambda () (text-scale-set 1))) ; Make font larger in org mode

(add-hook 'prog-mode-hook
          (lambda () (text-scale-set 0))) ; Reset font for programming modes

(setq doom-font (font-spec :family "Unifont" :size 16))
(setq doom-big-font-increment 6)
(setq doom-serif-font (font-spec :family "DejaVu Serif" :size 16))

(setq doom-theme 'cyberpunk)

;; Enable bold and italic for better syntax highlighting
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

;; Fine-tune cyberpunk colors for Doom UI elements
(after! cyberpunk-theme
  (custom-set-faces!
    ;; Make modeline pop more
    '(mode-line :background "#000000" :foreground "#ffffff")
    '(mode-line-inactive :background "#000000" :foreground "#5f8787")

    ;; Better line numbers
    '(line-number :foreground "#4a4a4a")
    '(line-number-current-line :foreground "#00ffff" :weight bold)))

(setq display-line-numbers-type `relative)

(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))

(display-time-mode t)

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

(use-package! prism
  :init
  (setq prism-desaturations '(10 15 20))
  :hook (((clojure-mode emacs-lisp-mode) . prism-mode)))

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
