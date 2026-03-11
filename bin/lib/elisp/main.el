#!/usr/bin/env -S emacs --script

(defvar elisp-directory
  (file-name-directory (file-truename (or load-file-name buffer-file-name))))

(defvar project-directory
  (file-name-directory
   (directory-file-name
    (file-name-directory
     (directory-file-name
      (file-name-directory
       (directory-file-name
        elisp-directory)))))))


(load-file (concat elisp-directory "config-tangle.el"))

(tangle-config (concat project-directory "config.org"))
