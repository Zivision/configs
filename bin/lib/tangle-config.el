#!/usr/bin/env -S emacs --script

;; Set project directory
(defvar project-directory
  (file-name-directory
   (directory-file-name
    (file-name-directory
     (directory-file-name
      (file-name-directory
       (file-truename (or load-file-name buffer-file-name))))))))


;; Tangle config.org
(require 'ob-tangle)
(print "Starting tangle...")
(defvar org-tangle-results (org-babel-tangle-file (concat project-directory "config.org")))

(seq-doseq (element org-tangle-results)
  (print (concat "File: '" element "' has been tangled")))
(print "Finished tangle")
