;;; tangle-configs.el --- Tangle org documents -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2026 Zachary Castro
;;
;; Author: Zivision
;; Maintainer: Zivision
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

(defun tangle-configs--build-directories
    (project-dir)
  "Build the needed directories for each package in 'build/'."

  ;; Loop over programs and if a file exists but not the directory
  ;; Build directory

  (seq-doseq
      (program (mapcar
                (lambda (file-path)
                  (file-name-sans-extension (file-name-nondirectory file-path)))
                (directory-files-recursively
                 (expand-file-name  "org/" project-dir ) "\\.org$")))
    (let ((file-path
           (expand-file-name program
                             (expand-file-name "build" "~/Workspace/Misc/configs"))))

      (unless (file-directory-p file-path)
        (make-directory file-path)))))

(defun tangle-configs-configure
    ()
  "Tangle all org documents in configs."

  (let* ((project-dir
          (thread-first (getenv "DOOMDIR")
                        (expand-file-name)
                        (file-name-directory)
                        (directory-file-name)
                        (file-name-directory)))


         ;; Library directory (not needed for now)
         ;;(lib-dir (expand-file-name "elisp/" project-dir ))

         ;; Build directory
         (build-dir (expand-file-name  "build/" project-dir)))

(tangle-configs--build-directories project-dir)

;; Check symbolic link of hardware configuration
(unless (file-symlink-p (expand-file-name "nixos/hardware-configuration.nix" build-dir))
  (let ((default-directory (expand-file-name "nixos" build-dir)))
    (message "Creating link")
    (make-symbolic-link "/etc/nixos/hardware-configuration.nix"
                        (expand-file-name "nixos/hardware-configuration.nix" build-dir))))

;; Map over all org files
(mapc
 (lambda (file-path) (org-babel-tangle-file file-path))
 (directory-files-recursively
  (expand-file-name  "org/" project-dir ) "\\.org$"))))

(defun tangle-configs-configure-interactive
    ()
  "Tangle all org documents in configs (interactively)."
  (interactive)
  (tangle-configs-configure))

(provide 'tangle-configs)
;;; tangle-configs.el ends here
