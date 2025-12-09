(use-modules (gnu home)
             (gnu packages)
             (gnu packages emacs)
             (gnu services)
             (guix gexp)
             (gnu home services shells))

(home-environment
  ;; Packages to install
  (packages (specifications->packages
             '("emacs"
               "git"
               "ripgrep"
               "fd"
               "shellcheck")))

(services
 (list
  ;; Manage your bash config
  (service home-bash-service-type
           (home-bash-configuration
            (aliases '(("ll" . "ls -l")
                       ("doom" . "~/.config/emacs/bin/doom")))
            (bashrc (list (local-file "bashrc.sh"))))))))
