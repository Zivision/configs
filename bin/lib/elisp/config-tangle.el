;; Tangle config.org
(require 'ob-tangle)
(defun tangle-config
    (directory)
  "Tangle the DIRECTORY listed"
  (message "Starting tangle...")
  (defvar org-tangle-results (org-babel-tangle-file directory))
  (seq-doseq (element org-tangle-results)
    (message (concat "File: '" element "' has been tangled")))
  (message "Finished tangle"))
