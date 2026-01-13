;; Run arandr to get a screen layout config
(run-shell-command "bash ~/.screenlayout/stumpwm.sh")

;; Launch polybar
;;(run-shell-command "bash ~/.config/stumpwm/launchpoly.sh")
;; Auto start script
(run-shell-command "bash ~/.config/stumpwm/autostart.sh")

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

;; Actual Modeline
(setf *time-modeline-string* "%a, %b %d %I:%M%p")
(setf *screen-mode-line-format*
      (list
       ;; Groups
       " ^7[^B^4%n^7^b] "
       ;; Pad to right
       "^>"
       '(:eval (when (> *reps* 0)
                 (format nil "^1^B(Reps ~A)^n " *reps*)))
       ;; Date
       "^7"
       "%d"
       ;; Battery
       " ^7[^n%B^7]^n "))

(defun enable-mode-line-everywhere ()
  (loop for screen in *screen-list* do
        (loop for head in (screen-heads screen) do
              (enable-mode-line screen head t))))
(enable-mode-line-everywhere)
;; turn on/off the mode line for the current head only.
(define-key *top-map* (kbd "s-B") "mode-line")

;; Configure gaps
(setf swm-gaps:*inner-gaps-size* 2
      swm-gaps:*outer-gaps-size* 5
      swm-gaps:*head-gaps-size* 0)
(when *initializing*
  (swm-gaps:toggle-gaps))
(define-key *top-map* (kbd "C-g") "toggle-gaps")
