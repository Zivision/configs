(defun find-script-location
    ()
  "Returns location of scripts."
  (setq script-location
        (file-name-directory
         (file-truename (or load-file-name (buffer-file-name)))))
  (setq script-project-root (string-replace "scripts/" "" script-location))

  ;; Return location of script and project root
  (list script-location script-project-root))
