;; channels.scm — copy to ~/.config/guix/channels.scm, OR use directly with:
;;   guix time-machine --channels=channels.scm -- system vm -L . systems/vm.scm
;;
;; NOTE: `guix system' does NOT read this file automatically.  Always use
;; `guix time-machine --channels=channels.scm' to get a reproducible build.
;;
;; After pushing the repo for the first time, pin the config channel by
;; adding: (commit "FIRST-COMMIT-HASH") and removing (branch "master").

(use-modules (guix channels))

(list (channel
        (name 'guix)
        (url "https://codeberg.org/guix/guix.git")
        (commit "41111228d516bf834bce5ad4b92fc7dfef1187de")
        (introduction
         (make-channel-introduction
          "9edb3f66fd807b096b48283debdcddccfea34bad"
          (openpgp-fingerprint
           "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA")))))
