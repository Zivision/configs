;; Enable mouse clicking to change window
(setf *mouse-focus-policy* :click)

;; Prefix key
(stumpwm:set-prefix-key (stumpwm:kbd "s-RET"))

;; Make windows floating
(define-key *root-map* (kbd "s-f") "float-this")
(define-key *root-map* (kbd "s-u") "unfloat-this")

;; Custom commands
(define-key *root-map* (stumpwm:kbd "p") "exec rofi -show drun")

(ql:quickload :swm-gaps)
(load-module "swm-gaps")

;; Run arandr to get a screen layout config
(run-shell-command "bash ~/.screenlayout/stumpwm.sh")

;; Auto start script
(run-shell-command "bash ~/.config/stumpwm/autostart.sh")
