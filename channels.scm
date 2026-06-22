;; channels.scm — copy to ~/.config/guix/channels.scm, OR use directly with:
;;   guix time-machine --channels=channels.scm -- system vm -L . systems/vm.scm
;;
;; NOTE: `guix system' does NOT read this file automatically.  Always use
;; `guix time-machine --channels=channels.scm' to get a reproducible build.
;;
;; After pushing the repo for the first time, pin the config channel by
;; adding: (commit "FIRST-COMMIT-HASH") and removing (branch "master").

(define-module (channels))

(use-modules (gnu packages nss))
(use-modules (guix channels))

(list (channel
        (name 'guix)
        (url "https://codeberg.org/guix/guix.git")
        (commit "dd00241787d9a4e91f31591b7be05a526286ebc1")
        (introduction
         (make-channel-introduction "9edb3f66fd807b096b48283debdcddccfea34bad"
          (openpgp-fingerprint
           "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA")))))
