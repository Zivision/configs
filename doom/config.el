(add-hook 'org-mode-hook
          (lambda () (text-scale-set 2))) ; Make font larger in org mode

(add-hook 'prog-mode-hook
          (lambda () (text-scale-set 0))) ; Reset font for programming modes

(setq doom-font (font-spec :family "Unifont" :size 20))
(setq doom-serif-font (font-spec :family "DejaVu Serif" :size 16))

;; Make doom large font even bigger
(setq doom-big-font-increment 6)

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

(after! doom-modeline
  ;; Configuration
  (setq doom-modeline-height 32
        doom-modeline-bar-width 5
        doom-modeline-icon t
        doom-modeline-major-mode-icon t
        doom-modeline-major-mode-color-icon t
        doom-modeline-buffer-file-name-style 'truncate-upto-project
        doom-modeline-buffer-encoding t
        doom-modeline-indent-info t
        doom-modeline-lsp t
        doom-modeline-env-version t
        doom-modeline-enable-word-count t
        doom-modeline-column-zero-based nil
        doom-modeline-minor-modes nil)
  
  ;; Cyberpunk neon colors
  (custom-set-faces!
    ;; Active mode-line - bright cyan with hot pink accent
    '(mode-line :background "#0a0a0a" :foreground "#00ffff" 
                :box (:line-width 4 :color "#ff1493" :style nil))
    
    ;; Inactive mode-line - subtle and dark
    '(mode-line-inactive :background "#050505" :foreground "#404040"
                         :box (:line-width 2 :color "#1a1a1a"))
    
    ;; Evil state colors (neon theme)
    '(doom-modeline-evil-insert-state :foreground "#ff1493" :weight bold)  ; Hot pink
    '(doom-modeline-evil-normal-state :foreground "#00ffff" :weight bold)  ; Cyan
    '(doom-modeline-evil-visual-state :foreground "#ff69b4" :weight bold)  ; Light pink
    '(doom-modeline-evil-replace-state :foreground "#ff00ff" :weight bold) ; Magenta
    '(doom-modeline-evil-motion-state :foreground "#00ff00" :weight bold)  ; Green
    '(doom-modeline-evil-emacs-state :foreground "#ffff00" :weight bold)   ; Yellow
    '(doom-modeline-evil-operator-state :foreground "#00ffff" :weight bold)
    
    ;; Buffer status
    '(doom-modeline-buffer-modified :foreground "#ff1493" :weight bold)
    '(doom-modeline-buffer-major-mode :foreground "#00ffff")
    '(doom-modeline-buffer-file :foreground "#00ffff" :weight bold)
    '(doom-modeline-buffer-path :foreground "#7f7f7f")
    
    ;; LSP and checker
    '(doom-modeline-lsp-success :foreground "#00ff00")
    '(doom-modeline-lsp-warning :foreground "#ffff00")
    '(doom-modeline-lsp-error :foreground "#ff1493")
    
    ;; Version control
    '(doom-modeline-vcs-info :foreground "#ff69b4")
    
    ;; Info sections
    '(doom-modeline-info :foreground "#00ffff")
    '(doom-modeline-warning :foreground "#ffff00")
    '(doom-modeline-urgent :foreground "#ff1493" :weight bold)
    
    ;; Bar (the colored line on the left)
    '(doom-modeline-bar :background "#ff1493")
    '(doom-modeline-bar-inactive :background "#1a1a1a")))

(display-time-mode 1)
(display-battery-mode 1)

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
  (setq org-hide-emphasis-markers t)

(custom-set-faces!
    '(org-block :background "#000000")  ; Pure black or use nil
    '(org-block-begin-line :background nil :foreground "#00ffff" :height 0.9)
    '(org-block-end-line :background nil :foreground "#00ffff" :height 0.9)))

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
