#!/usr/bin/emacs --script


;; String of all stow packages
(setq stow-packages
     '(("doom" . "stow doom -t ~/.config/doom")
       ("home" . "stow home -t ~")))

;; Loop over list and stow packages
(cl-loop for (key . value) in stow-packages
         collect (shell-command value))

