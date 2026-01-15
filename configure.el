#!/usr/bin/emacs --script

;; String of all stow packages
(setq stow-packages
     '(("doom" . "stow doom -t ~/.config/doom")
       ("home" . "stow home -t ~")))

;; Loop over list and stow packages
(defun loop-over-packages
    (packages)
  "Loop over stow PACKAGES"
  (cl-loop for (key . value) in packages
         collect (shell-command value)))

(loop-over-packages stow-packages)
