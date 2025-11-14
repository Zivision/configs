(setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :size 20))
(setq doom-serif-font (font-spec :family "DejaVu Serif" :size 20))

(setq doom-theme 'moe-dark)

(setq display-line-numbers-type `relative)

(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))

(use-package! emms
  :config
  (setq emms-source-file-default-directory "~/Music/Music")
  (setq emms-player-list '(emms-player-mpv)))

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
          ("DONE" :background "green" :foreground "white")
          ("NOTE" :background "yellow" :foreground "black")))
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
