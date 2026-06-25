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

(defun tangle-configs--manual-link-firefox
    (target-dir build-dir file)
  "Manually link of a certain FILE in BUILD-DIR to TARGET-DIR."

(let ((paths
       (mapcar
        (lambda (path)
          (file-name-directory (expand-file-name path)))
        (directory-files-recursively target-dir "prefs.js"))))

(mapcar (lambda (path)
          (unless (file-symlink-p
                   (expand-file-name file path))
            (make-symbolic-link (expand-file-name file build-dir)
                                (expand-file-name file path))))
        paths)))

(defun tangle-configs--build-directories
    (project-dir build-dir)
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
           (expand-file-name program build-dir)))

      (unless (file-directory-p file-path)
        (make-directory file-path)))))

(defun tangle-configs-configure
    (project-dir build-dir)
  "Tangle all org documents in configs."

(tangle-configs--build-directories project-dir build-dir)

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
  (expand-file-name  "org/" project-dir ) "\\.org$"))

(tangle-configs--manual-link-firefox "~/.mozilla/firefox"
                                     (expand-file-name "firefox" build-dir)
                                     "user.js")

); End of Function

(defun tangle-configs-configure-interactive
    ()
  "Tangle all org documents in configs (interactively)."
  (interactive)
  (tangle-configs-configure))

(provide 'tangle-configs)
;;; tangle-configs.el ends here
