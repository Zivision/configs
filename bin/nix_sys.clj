#!/usr/bin/env bb
(require '[babashka.process :refer [shell]])

;; Get the true (not symlink) location of script
(def script-dir
  (.getParent (.getCanonicalFile (java.io.File. *file*))))

;; Then the project
(def project-dir
  (.getParent (java.io.File. script-dir)))

;; Config system
(defn sys-config []
  (shell "stow-configs"))

;; Rebuild system
(defn sys-rebuild []
  (shell
   (str
    "sudo nixos-rebuild switch --flake \""
    project-dir
    "/nixos\" --impure")))

;; Update then rebuild
(defn sys-update []
  (shell
   (str
    "nix flake update --flake \""
    project-dir
    "/nixos\""))
  (sys-rebuild))

(if (seq *command-line-args*)
  (doseq [arg *command-line-args*]
    (case arg
      "-c" (sys-config)
      "-r" (sys-rebuild)
      "-u" (sys-update)))
  (sys-rebuild))
