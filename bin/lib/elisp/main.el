#!/usr/bin/env -S emacs --script

;; Get elisp library folder
(defvar elisp-directory
  (file-name-directory (file-truename (or load-file-name buffer-file-name))))

;; Get the project root
(defvar project-root
  (file-name-directory
   (directory-file-name
    (file-name-directory
     (directory-file-name
      (file-name-directory
       (directory-file-name
        elisp-directory)))))))


;; Load external file
(load-file (concat elisp-directory "config-tangle.el"))

;; Org documents to tangle
(seq-doseq (element '("bashrc.org"
                      "doom.org"
                      "hyprland.org"
                      "kitty.org"
                      "nixos.org"
                      "waybar.org"))
  (tangle-config (concat project-root "org/" element)))
