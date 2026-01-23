#!/usr/bin/emacs --script

(defun install-depends
    (dependancies)
  "Install DEPENDANCIES."
  (dolist (dep dependancies)
    (shell-command (format "apt install %s -y" dep))))

;; Update repos
(shell-command "apt update")
(message "Repos updated")

;; General dependancies I want on my machine
(setq general-dependancies
      '("stow"
        "ripgrep"
        "fd-find"))
(install-depends general-dependancies)

(message "General dependancies installed.")

;; Doom emacs dependancies
(setq doom-dependancies
      '("libjansson4"
        "libjansson-dev"
        ;; vterm
        "cmake"
        "libtool-bin"))

(install-depends doom-dependancies)
(message "Doom dependancies installed.")

;; This will install doom emacs
;; Uncomment to install it
;(shell-command "git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs")
;(shell-command "~/.config/emacs/bin/doom install")
(message "Doom installed")

;; Configure machine
(load-file "configure.el")
(loop-over-packages stow-packages)

(message "All done! Enjoy doom emacs!")
