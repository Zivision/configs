;; Tangle config.org
(require 'ob-tangle)
(defun tangle-config
    (file)
  "Tangle the FILE listed"
  (message "Starting tangle...")
  (defvar org-tangle-results (org-babel-tangle-file file))
  (seq-doseq (element org-tangle-results)
    (message (concat "File: '" element "' has been tangled")))
  (message "Finished tangle"))
