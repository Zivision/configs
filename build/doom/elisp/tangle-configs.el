;;; tangle-configs.el --- Tangle org documents -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2026 Primary
;;
;; Author: Zivision
;; Maintainer: Zivision <primary@nixos>
;; Created: May 13, 2026
;; Modified: May 13, 2026
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex text tools unix vc wp
;; Homepage: https://github.com/primary/tangle-configs
;; Package-Requires: ((emacs "25.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:
(require 'subr-x)
(require 'ob-tangle)

(defun tangle-configs-configure
    ()
  "Tangle all org documents in configs"
  (let* ((project-dir
          (thread-first
            ;; Get project directory on machine
            (or load-file-name
                buffer-file-name)
            (file-name-directory)
            (directory-file-name)
            (file-name-directory)
            (file-truename)))
         ;; Library directory (not needed for now)
         ;;(lib-dir (expand-file-name "elisp/" project-dir ))

         ;; Build directory
         (build-dir (expand-file-name  "build/" project-dir)))

    ;; Check symbolic link of hardware configuration
    (unless (file-symlink-p (expand-file-name "nixos/hardware-configuration.nix" build-dir))
      (let ((default-directory (expand-file-name "nixos" build-dir)))
        (message "Creating link")
        (make-symbolic-link "/etc/nixos/hardware-configuration.nix"
                            (expand-file-name "nixos/hardware-configuration.nix" build-dir))))
    ;; Map over all org files
    (mapc
     #'(lambda (file-path)
         (org-babel-tangle-file file-path)
         (when (string= (file-name-nondirectory file-path) "doom.org")
           (progn
             (message "Starting: DOOM Sync")
             (start-process-shell-command
              "doom-sync"
              "*Output*"
              "doom sync"))))
     (directory-files-recursively (expand-file-name  "org/" project-dir ) "\\.org$"))))


(defun tangle-configs-configure-interactive
    ()
  "Tangle all org documents in configs (interactively)"
  (interactive)
  (tangle-configs-configure))


(provide 'tangle-configs)
;;; tangle-configs.el ends here
