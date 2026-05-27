;; systems/desktop.scm — Guix Home configuration for the desktop machine
;;
;; Usage:
;;   guix home reconfigure -L . systems/desktop.scm
;;
;; The -L . flag adds the repo root to the Guile load path so that
;; (systems common) and (config packages ...) modules are found.
;;
;; All definitions live in systems/common.scm; this file just surfaces the
;; home-environment so `guix home' has a top-level expression to evaluate.

(use-modules (systems common))

%desktop-home-environment
