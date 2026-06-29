;; Basic Settings
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(setq inhibit-startup-screen t
      use-short-answers t)
(electric-pair-mode 1)
(recentf-mode t)


;; Disable auto-save (#file#) entirely and backups
(setq auto-save-default nil
	make-backup-files nil
      create-lockfiles nil)

(setq-default indent-tabs-mode nil
	      tab-width 4)
(setq indent-line-function 'insert-tab)

(use-package dashboard
  :ensure t
  :config
  (setq initial-buffer-choice 'dashboard-open)
  (dashboard-setup-startup-hook))

(use-package beacon
  :config
  (setq beacon-size 30
        beacon-color "tan"
        beacon-blink-duration 0.9
        beacon-blink-delay 0.0)
  (beacon-mode 1))

(use-package nerd-icons-completion
  :after vertico
  :config
  (nerd-icons-completion-mode))

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package golden-ratio
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

(setq display-buffer-alist
      '(
        ;; EWW
        ("\\*eww\\*"
         (display-buffer-reuse-mode-window
          display-buffer-same-window))

        ;; Proced
        ("\\*Proced*"
         (display-buffer-reuse-mode-window
          display-buffer-same-window))
        ))

(use-package doom-modeline
  :config
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
	doom-modeline-minor-modes nil)
  (doom-modeline-mode t))
;; For clock
(display-time-mode 1)

(require 'jazz-theme)
(load-theme 'jazz t)

(add-to-list 'default-frame-alist
             '(font . "Iosevka Nerd Font Mono 14"))

(add-hook 'org-mode-hook
          (lambda () (text-scale-set 1))) ; Make font larger in org mode

(add-hook 'prog-mode-hook
          (lambda () (text-scale-set 0))) ; Reset font for programming modes

;; Set the type of line numbers to relative
(setq-default display-line-numbers-type 'relative)


(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'org-mode-hook 'display-line-numbers-mode)

(use-package vterm :ensure t)

;; Syntax Highlighting
(use-package eshell-syntax-highlighting
  :after eshell-mode
  :config
  (eshell-syntax-highlighting-global-mode t))

;; Eshell prompt extras
(require 'eshell-prompt-extras)
(with-eval-after-load "esh-opt"
  (autoload 'epe-theme-lambda "eshell-prompt-extras")
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-lambda))

;; Better clear
(defun eshell/clear ()
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))

(use-package magit :ensure t)

;; Basic package setup (assumes use-package or package-install)
(require 'emms-setup)
(emms-all)                      ;; enables core EMMS features
(emms-default-players)          ;; register default players

;; Use mpv as the external player (recommended)
(setq emms-player-list '(emms-player-mpv))
(setq emms-player-mpv-parameters '("--no-terminal" "--ontop=no"))

;; Optional: directory to scan for music
(setq emms-source-file-default-directory "~/Music/")

(require 'elfeed-org)
(elfeed-org)
(setq rmh-elfeed-org-files (list "~/Documents/org/elfeed.org"))

(use-package envrc
  :hook (after-init . envrc-global-mode))

(use-package vertico
  :custom
  (vertico-scroll-margin 0) ;; Different scroll margin
  (vertico-count 20) ;; Show more candidates
  (vertico-resize nil) ;; Grow and shrink the Vertico minibuffer
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (require 'vertico)
  (vertico-mode t))
(use-package vertico-directory
  :ensure nil
  :bind (:map vertico-map
	      ("DEL" . vertico-directory-delete-char)
	      ("M-DEL" . vertico-directory-delete-word)))

(use-package savehist
  :init
  (savehist-mode t))

(use-package dabbrev
  ;; Swap M-/ and C-M-/
  :bind (("M-/" . dabbrev-completion)
	 ("C-M-/" . dabbrev-expand))
  :config
  (add-to-list 'dabbrev-ignored-buffer-regexps "\\` ")
  (add-to-list 'dabbrev-ignored-buffer-modes 'authinfo-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'doc-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'pdf-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'tags-table-mode))

(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match 'insert) ;; Configure handling of exact matches

  ;; Enable Corfu only for certain modes. See also `global-corfu-modes'.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  :init
  (require 'corfu)

  ;; Recommended: Enable Corfu globally.  Recommended since many modes provide
  ;; Capfs and Dabbrev can be used globally (M-/).  See also the customization
  ;; variable `global-corfu-modes' to exclude certain modes.
  (global-corfu-mode)

  ;; Enable optional extension modes:
  ;; (corfu-history-mode)
  ;; (corfu-popupinfo-mode)

  ;; Enable auto completion, configure delay, trigger and quitting
  (setq corfu-auto t
	corfu-auto-delay 0.2
	corfu-auto-trigger "." ;; Custom trigger characters
	corfu-quit-no-match 'separator) ;; or t
  )
;; Add extensions
(use-package cape
  :ensure t
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :bind ("C-c p" . cape-prefix-map) ;; Alternative key: M-<tab>, M-p, M-+
  ;; Alternatively bind Cape commands individually.
  ;; :bind (("C-c p d" . cape-dabbrev)
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ...)
  :init
  (require 'cape)
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-abbrev)
  ;;(add-hook 'completion-at-point-functions #'cape-keyword)
  (add-hook 'completion-at-point-functions #'cape-line)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  ;;(add-hook 'completion-at-point-functions #'cape-history)
  )

(use-package consult :ensure t)

(use-package orderless
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil) ;; Disable defaults, use our settings
  (completion-pcm-leading-wildcard t))

;; Core Python setup with Eglot + basedpyright
(use-package eglot
  :hook ((python-mode python-ts-mode) . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
	       '((python-mode python-ts-mode) . ("pyright-langserver" "--stdio"))))

;; Formatting
(use-package apheleia
  :ensure t
  :config
  (apheleia-global-mode +1)
  (setf (alist-get 'nix-mode apheleia-mode-alist) 'nixfmt))

;; Nix syntax highlighting and indentation
(use-package nix-mode
  :defer t
  :ensure t
  :mode "\\.nix\\'")

;; Virtualenv
(use-package pyvenv
  :defer t
  :ensure t
  :config (pyvenv-mode 1))

;; Or the more automatic option:
(use-package pet
  :defer t
  :ensure t
  :config
  (add-hook 'python-base-mode-hook 'pet-mode -10))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  ;; Add Embark to the mouse context menu. Also enable `context-menu-mode'.
  ;; (context-menu-mode 1)
  ;; (add-hook 'context-menu-functions #'embark-context-menu 100)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t) ; only need to install it, embark loads it after consult if found

(use-package emacs
  :custom
  ;; TAB cycle if there are only few candidates
  ;; (completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function.
  ;; Try `cape-dict' as an alternative.
  (text-mode-ispell-word-completion t)
  ;;(cape-dict t)

  ;; Hide commands in M-x which do not apply to the current mode.  Corfu
  ;; commands are hidden, since they are not used via M-x. This setting is
  ;; useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Enable context menu. `vertico-multiform-mode' adds a menu in the minibuffer
  ;; to switch display modes.
  (context-menu-mode t)
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode t))

(use-package evil-collection
  :init
  :config
  (evil-collection-init))

(use-package undo-fu)

;; Undo Limit
(setq undo-limit 67108864) ; 64mb.
(setq undo-strong-limit 100663296) ; 96mb.
(setq undo-outer-limit 1006632960) ; 960mb.

(use-package which-key
  :defer t
  :config
  (which-key-mode))

(use-package general
  :ensure t
  :config

  (general-evil-setup t)

  ;; Org Mode enter key
  (general-define-key
   :states '(normal motion)
   :keymaps 'org-mode-map
   "RET" (lambda ()
           (interactive)
           (if (org-element-lineage
                (org-element-context)
                '(link)
                t)
               (org-open-at-point)
             (evil-ret))))
  
  ;; Define a space-leader-definer for the SPC prefix
  (general-create-definer space-leader-def
    :prefix "SPC"
    :states '(normal visual motion)
    :keymaps 'override)

  ;; Simulate C-w when pressing SPC w
  (space-leader-def
    "w" 'evil-window-map
    "." 'find-file
    "," 'consult-buffer
    )

  (space-leader-def
    :prefix "SPC o"
    "e" 'eshell
    "t" 'vterm)

  (space-leader-def
    :prefix "SPC g"
    "g" 'magit)
  
  ;; Buffers
  (space-leader-def
    :prefix "SPC b"
    "i" 'ibuffer
    "h" 'previous-buffer
    "l" 'next-buffer
    "k" 'kill-current-buffer)

  ;; Help functions
  (space-leader-def
    :prefix "SPC h"
    "f" 'describe-function
    "v" 'describe-variable
    "t" 'consult-theme)

  
  (space-leader-def
    :prefix "SPC s"
    "s" 'consult-line
    "S" 'consult-ripgrep)


  ;; EMMS
  (space-leader-def
    :prefix "SPC m"
    "e" 'emms
    "p" 'emms-pause
    "R" (lambda ()
          (interactive)
          (kill-buffer "*EMMS Playlist*")
          (emms-add-directory "~/Music")
          (emms))
    "l" 'emms-seek-forward
    "h" 'emms-seek-backward
    "j" 'emms-next
    "k" 'emms-previous)

  ;; Misc
  (space-leader-def
    "c c" 'compile)
  
  ;;; Org
  (space-leader-def
    :prefix "SPC n"
    "f" 'org-roam-node-find
    "i" 'org-roam-node-insert
    "c" 'org-roam-capture
    "t" 'org-roam-buffer-toggle
    "d" 'org-roam-dailies-goto-today
    "y" 'org-roam-dailies-capture-today)

  ;; Org Capture
  (space-leader-def
    "X" 'org-capture)
  )

(use-package org
  :hook (org-mode . org-indent-mode)
  :init
  (setq org-directory "~/Documents/org")
  (setq org-agenda-files
        `(,(expand-file-name "agenda/agenda.org" org-directory)
          ,(expand-file-name "todo.org" org-directory)))
  (setq org-hide-emphasis-markers t)
  (setq org-default-notes-file (expand-file-name "notes.org" org-directory))

  :config
  (require 'org-tempo)

  ;; Org Babel
  (setq org-confirm-babel-evaluate nil)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (shell . t)))

  ;; Show results of python execution
  (with-eval-after-load 'ob-python
  (setq org-babel-default-header-args:python
        '((:results . "output")
          (:session . "none")
          (:exports . "both"))))

  )

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-directory (file-truename "~/Documents/org/roam"))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?" :target
           (file+head
            "%<%Y%m%d%H%M%S>-${slug}.org"
            "#+title: ${title}\nHead to the [[id:6c8c0623-2b7f-4717-9985-2733777df46e][Home-Node]]\n")
           :unnarrowed t))))

(add-hook 'org-mode-hook
          (lambda ()
            (setq-local electric-pair-inhibit-predicate
                        (lambda (c)
                          (if (char-equal c ?<)
                              t
                            (electric-pair-default-inhibit c))))))

(setq org-capture-templates
      `(("t" "Personal todo" ; Todo items
        entry (file+headline
               ,(expand-file-name "todo.org" org-directory)
               " Capture Tasks")
        ,(concat
         "* [ ] [#B] TODO %? "
         (format-time-string "<%Y-%m-%d %a>"
                             (org-read-date nil t "Fri"))
         "\n\n%a")
        :prepend t)


       ;; Notes
       ("n" "Personal notes"
        entry (file+headline
               ,(expand-file-name "notes.org" org-directory)
               "Capture Notes")
        "* %u %?\n%i\n%a" :prepend t)))

(use-package org-modern
  :defer t
  :hook (org-mode . org-modern-mode)
  :config
  ;; Basic settings
  (setq org-modern-replace-stars "󰏝󰏝󰏝󰏝󰏝󰏝"
        org-modern-star 'replace
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
        org-src-preserve-indentation t)) ; Preserve indentation

(use-package org-appear
  :defer t
  :after org-modern
  :hook (org-mode . org-appear-mode))

(use-package toc-org
  :defer t
  :hook (org-mode . toc-org-mode))

(use-package olivetti
  :defer t
  :hook
  (org-mode . olivetti-mode)
  (eww-mode . olivetti-mode)
  :init (setq olivetti-body-width 125))

(setq-default truncate-lines t)

(setq vc-follow-symlinks t)

(setq confirm-kill-emacs
      #'y-or-n-p)
