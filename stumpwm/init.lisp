;; Enable mouse clicking to change window
(setf *mouse-focus-policy* :click)

;; Prefix key
(stumpwm:set-prefix-key (stumpwm:kbd "s-RET"))

;; Run arandr to get a screen layout config
(run-shell-command "bash ~/.screenlayout/stumpwm.sh")

;; Auto start script
(run-shell-command "bash ~/.config/stumpwm/autostart.sh")


;; Custom commands
(define-key *root-map* (stumpwm:kbd "p") "exec rofi -show drun")

;; Make windows floating
(define-key *root-map* (kbd "s-f") "float-this")
(define-key *root-map* (kbd "s-u") "unfloat-this")

;; Floating windows
(defun auto-float-window (window)
  (let ((class (window-class window)))
    (when (or (string-equal class "Steam")
              (string-equal class "Gimp")
              (string-equal class "Pavucontrol"))
      (float-window window (current-group)))))

(add-hook *new-window-hook* #'auto-float-window)
