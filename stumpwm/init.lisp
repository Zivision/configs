;; Add contrib to load path
(add-to-load-path "~/Workspace/Misc/configs/stumpwm/modules/stumpwm-contrib/util/swm-gaps")

;; Load swm-gaps
(load-module "swm-gaps")

;; Enable mouse clicking to change window
(setf *mouse-focus-policy* :click)

;; Prefix key
(stumpwm:set-prefix-key (stumpwm:kbd "s-RET"))

;; Make windows floating
(define-key *root-map* (kbd "s-f") "float-this")
(define-key *root-map* (kbd "s-u") "unfloat-this")

(define-key *root-map* (kbd "s-R") "loadrc")

;; Custom commands
(define-key *root-map* (stumpwm:kbd "p") "exec rofi -show drun")

;; Custom commands
;; Set focused window border color
(set-focus-color "magenta")

;; Set unfocused window border color
(set-unfocus-color "black")

;; Configure gaps
(setf swm-gaps:*head-gaps-size* 2
      swm-gaps:*inner-gaps-size* 2)
(swm-gaps:toggle-gaps)

;; Run arandr to get a screen layout config
(run-shell-command "bash ~/.screenlayout/stumpwm.sh")

;; Auto start script
(run-shell-command "bash ~/.config/stumpwm/autostart.sh")
